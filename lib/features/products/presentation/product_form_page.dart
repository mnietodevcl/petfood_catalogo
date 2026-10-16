import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/database/app_database.dart';
import '../../../core/theme/app_colors.dart';
import '../data/product_image_service.dart';
import '../data/product_providers.dart';
import '../data/product_repository.dart';

// ============================================================
// MODELOS TEMPORALES DEL FORMULARIO
// ============================================================

class _ProductPhoto {
  const _ProductPhoto.gallery(this.file) : path = null, url = null;

  const _ProductPhoto.local(this.path) : file = null, url = null;

  const _ProductPhoto.remote(this.url) : file = null, path = null;

  final XFile? file;
  final String? path;
  final String? url;
}

class _NutrientDraft {
  _NutrientDraft({String name = '', String amount = '', this.unit = '%'})
    : nameController = TextEditingController(text: name),
      amountController = TextEditingController(text: amount);

  final TextEditingController nameController;
  final TextEditingController amountController;
  String unit;

  void dispose() {
    nameController.dispose();
    amountController.dispose();
  }
}

// ============================================================
// FORMULARIO COMPARTIDO: AGREGAR / EDITAR
// ============================================================

class ProductFormPage extends ConsumerStatefulWidget {
  const ProductFormPage({super.key, this.productId});

  final int? productId;

  bool get isEditing => productId != null;

  @override
  ConsumerState<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends ConsumerState<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _presentationController = TextEditingController();
  final _servingController = TextEditingController();

  final _imageService = ProductImageService();
  final _picker = ImagePicker();

  static const _categories = [
    'Perros',
    'Gatos',
    'Cachorros',
    'Gatitos',
    'Adultos',
    'Senior',
    'Otros',
  ];

  static const _units = ['%', 'g', 'mg', 'kcal', 'UI/kg', 'mg/kg'];

  static const _references = [
    'Análisis garantizado',
    'Por 100 g',
    'Por 1 kg',
    'Por porción',
  ];

  String? _category;
  String _reference = 'Análisis garantizado';

  _ProductPhoto? _mainPhoto;

  final List<_ProductPhoto> _nutritionPhotos = [];
  final List<_NutrientDraft> _nutrients = [];
  final List<_NutrientDraft> _allNutrientDrafts = [];

  // Imágenes originales para limpiar las reemplazadas
  // únicamente después de actualizar SQLite.
  final Set<String> _originalImagePaths = {};

  bool _loading = false;
  bool _saving = false;
  String? _loadError;

  // ============================================================
  // INICIALIZACIÓN
  // ============================================================

  @override
  void initState() {
    super.initState();

    if (widget.isEditing) {
      _loading = true;
      _loadProduct();
    }
  }

  // ============================================================
  // CARGAR PRODUCTO EXISTENTE
  // ============================================================

  Future<void> _loadProduct() async {
    try {
      final repository = ref.read(productRepositoryProvider);
      final id = widget.productId!;

      final product = await repository.getProductById(id);

      if (product == null) {
        throw StateError('Producto no encontrado');
      }

      final images = await repository.getNutritionImages(id);
      final values = await repository.getNutritionValues(id);

      if (!mounted) return;

      setState(() {
        _nameController.text = product.name;
        _descriptionController.text = product.description;
        _priceController.text = product.price.round().toString();
        _presentationController.text = product.presentation ?? '';

        _category = product.category;

        // Imagen principal
        if (product.productImagePath != null &&
            product.productImagePath!.isNotEmpty) {
          _mainPhoto = _ProductPhoto.local(product.productImagePath);

          _originalImagePaths.add(product.productImagePath!);
        } else if (product.productImageUrl != null &&
            product.productImageUrl!.isNotEmpty) {
          _mainPhoto = _ProductPhoto.remote(product.productImageUrl);
        }

        // Fotografías nutricionales
        for (final image in images) {
          if (image.imagePath != null && image.imagePath!.isNotEmpty) {
            _nutritionPhotos.add(_ProductPhoto.local(image.imagePath));

            _originalImagePaths.add(image.imagePath!);
          } else if (image.imageUrl != null && image.imageUrl!.isNotEmpty) {
            _nutritionPhotos.add(_ProductPhoto.remote(image.imageUrl));
          }
        }

        // Nutrientes registrados
        if (values.isNotEmpty) {
          final basis = values.first.referenceBasis ?? 'Análisis garantizado';

          if (basis.startsWith('Por porción (') && basis.endsWith(')')) {
            _reference = 'Por porción';
            _servingController.text = basis.substring(12, basis.length - 1);
          } else if (_references.contains(basis)) {
            _reference = basis;
          }

          for (final value in values) {
            final amount = value.amount.toString();

            final displayAmount = amount.endsWith('.0')
                ? amount.substring(0, amount.length - 2)
                : amount.replaceAll('.', ',');

            final draft = _NutrientDraft(
              name: value.nutrientName,
              amount: displayAmount,
              unit: value.unit,
            );

            _nutrients.add(draft);
            _allNutrientDrafts.add(draft);
          }
        }

        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _loadError = 'No se pudo cargar el producto.';
      });
    }
  }

  // ============================================================
  // LIBERAR RECURSOS
  // ============================================================

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _presentationController.dispose();
    _servingController.dispose();

    for (final draft in _allNutrientDrafts) {
      draft.dispose();
    }

    super.dispose();
  }

  // ============================================================
  // MENSAJES
  // ============================================================

  void _message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), behavior: SnackBarBehavior.floating),
    );
  }

  // ============================================================
  // SELECCIONAR IMAGEN PRINCIPAL
  // ============================================================

  Future<void> _pickMainImage() async {
    try {
      final file = await _imageService.pickFromGallery();

      if (!mounted || file == null) return;

      setState(() {
        _mainPhoto = _ProductPhoto.gallery(file);
      });
    } catch (_) {
      if (mounted) {
        _message('No se pudo seleccionar la fotografía.');
      }
    }
  }

  // ============================================================
  // INGRESAR URL DE IMAGEN
  // ============================================================

  Future<String?> _askImageUrl({String? initial}) {
    final formKey = GlobalKey<FormState>();
    String text = initial ?? '';

    return showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Imagen desde URL'),
          content: Form(
            key: formKey,
            child: TextFormField(
              initialValue: text,
              autofocus: true,
              keyboardType: TextInputType.url,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'https://ejemplo.com/imagen.jpg',
                labelText: 'URL HTTPS',
              ),
              onChanged: (value) => text = value,
              validator: (value) {
                if (!ProductImageService.isValidImageUrl(value ?? '')) {
                  return 'Ingresa una URL HTTPS válida';
                }

                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.of(dialogContext).pop(text.trim());
                }
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _setMainUrl() async {
    final url = await _askImageUrl(initial: _mainPhoto?.url);

    if (!mounted || url == null) return;

    setState(() {
      _mainPhoto = _ProductPhoto.remote(url);
    });
  }

  // ============================================================
  // FOTOGRAFÍAS NUTRICIONALES
  // ============================================================

  Future<void> _pickNutritionImages() async {
    try {
      final files = await _picker.pickMultiImage(
        imageQuality: 85,
        maxWidth: 1800,
      );

      if (!mounted || files.isEmpty) return;

      setState(() {
        _nutritionPhotos.addAll(files.map(_ProductPhoto.gallery));
      });
    } catch (_) {
      if (mounted) {
        _message('No se pudieron seleccionar las imágenes.');
      }
    }
  }

  Future<void> _addNutritionUrl() async {
    final url = await _askImageUrl();

    if (!mounted || url == null) return;

    setState(() {
      _nutritionPhotos.add(_ProductPhoto.remote(url));
    });
  }

  // ============================================================
  // NUTRIENTES
  // ============================================================

  void _addNutrient() {
    final draft = _NutrientDraft();

    setState(() {
      _nutrients.add(draft);
      _allNutrientDrafts.add(draft);
    });
  }

  void _removeNutrient(_NutrientDraft draft) {
    setState(() {
      _nutrients.remove(draft);
    });
  }

  String _referenceBasis() {
    if (_reference == 'Por porción') {
      return 'Por porción (${_servingController.text.trim()})';
    }

    return _reference;
  }

  // ============================================================
  // GUARDAR IMAGEN EN ALMACENAMIENTO LOCAL
  // ============================================================

  Future<String?> _persistPhoto(
    _ProductPhoto photo,
    List<String> newlySaved,
  ) async {
    if (photo.file != null) {
      final path = await _imageService.saveLocalImage(photo.file!);

      newlySaved.add(path);
      return path;
    }

    return photo.path;
  }

  // ============================================================
  // GUARDAR O ACTUALIZAR PRODUCTO
  // ============================================================

  Future<void> _save() async {
    if (_saving || !_formKey.currentState!.validate()) {
      return;
    }

    if (_mainPhoto == null) {
      _message('Selecciona la fotografía principal.');
      return;
    }

    final priceText = _priceController.text.replaceAll(RegExp(r'[^0-9]'), '');

    final price = double.tryParse(priceText);

    if (price == null || price <= 0) {
      _message('Ingresa un precio válido.');
      return;
    }

    final nutrients = <NutritionValueInput>[];

    for (final row in _nutrients) {
      final amount = double.tryParse(
        row.amountController.text.trim().replaceAll(',', '.'),
      );

      if (amount == null) {
        _message('Revisa los valores nutricionales.');
        return;
      }

      nutrients.add(
        NutritionValueInput(
          nutrientName: row.nameController.text.trim(),
          amount: amount,
          unit: row.unit,
          referenceBasis: _referenceBasis(),
        ),
      );
    }

    setState(() => _saving = true);

    final newlySaved = <String>[];
    bool committed = false;

    try {
      final main = _mainPhoto!;

      final mainPath = await _persistPhoto(main, newlySaved);

      final imageInputs = <NutritionImageInput>[];

      final retainedPaths = <String>{?mainPath};

      for (final photo in _nutritionPhotos) {
        final path = await _persistPhoto(photo, newlySaved);

        if (path != null) {
          retainedPaths.add(path);

          imageInputs.add(NutritionImageInput.fromGallery(path));
        } else if (photo.url != null) {
          imageInputs.add(NutritionImageInput.fromUrl(photo.url!));
        }
      }

      final companion = ProductsCompanion.insert(
        name: _nameController.text.trim(),
        category: _category!,
        description: _descriptionController.text.trim(),
        price: price,
        presentation: Value(
          _presentationController.text.trim().isEmpty
              ? null
              : _presentationController.text.trim(),
        ),
        productImagePath: Value(mainPath),
        productImageUrl: Value(main.url),
      );

      final repository = ref.read(productRepositoryProvider);

      if (widget.isEditing) {
        final updated = await repository.updateProductWithNutrition(
          widget.productId!,
          companion,
          images: imageInputs,
          nutrients: nutrients,
        );

        if (!updated) {
          throw StateError('Producto no encontrado');
        }
      } else {
        await repository.createProductWithNutrition(
          companion,
          images: imageInputs,
          nutrients: nutrients,
        );
      }

      committed = true;

      // Eliminar fotografías anteriores reemplazadas.
      // Se hace solo después de actualizar SQLite.
      if (widget.isEditing) {
        final obsoletePaths = _originalImagePaths.difference(retainedPaths);

        for (final path in obsoletePaths) {
          try {
            await _imageService.deleteLocalImage(path);
          } catch (_) {
            // No revertir una actualización ya confirmada.
          }
        }
      }

      if (!mounted) return;

      final messenger = ScaffoldMessenger.of(context);

      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/home');
      }

      messenger.showSnackBar(
        SnackBar(
          content: Text(
            widget.isEditing
                ? 'Producto actualizado correctamente'
                : 'Producto guardado correctamente',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (_) {
      if (!committed) {
        for (final path in newlySaved) {
          try {
            await _imageService.deleteLocalImage(path);
          } catch (_) {
            // Continuar limpiando las demás imágenes.
          }
        }
      }

      if (mounted) {
        _message('No se pudo guardar el producto.');
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  // ============================================================
  // ELIMINAR PRODUCTO CON CONFIRMACIÓN
  // ============================================================

  Future<void> _deleteProduct() async {
    if (!widget.isEditing || _saving) return;

    // Confirmación obligatoria antes de eliminar.
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('¿Eliminar producto?'),
          content: Text(
            'Se eliminará "${_nameController.text.trim()}" '
            'del catálogo, junto con sus fotografías '
            'e información nutricional.\n\n'
            'Esta acción no se puede deshacer.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !mounted) return;

    setState(() => _saving = true);

    try {
      final repository = ref.read(productRepositoryProvider);
      final productId = widget.productId!;

      // 1. Consultar el producto antes de eliminarlo.
      final product = await repository.getProductById(productId);

      if (product == null) {
        throw StateError('Producto no encontrado');
      }

      // 2. Consultar fotografías nutricionales.
      final nutritionImages = await repository.getNutritionImages(productId);

      // 3. Guardar las rutas de imágenes locales
      // para limpiarlas posteriormente.
      final imagePaths = <String>{
        ?product.productImagePath,
        for (final image in nutritionImages) ?image.imagePath,
      };

      // 4. Eliminar de SQLite.
      // Las tablas nutricionales se eliminan en cascada.
      final deleted = await repository.deleteProduct(productId);

      if (!deleted) {
        throw StateError('No se pudo eliminar el producto');
      }

      // 5. Eliminar fotografías locales.
      // Nunca antes de confirmar la eliminación en SQLite.
      for (final path in imagePaths) {
        try {
          await _imageService.deleteLocalImage(path);
        } catch (_) {
          // Si falla la limpieza de un archivo, la
          // eliminación de SQLite permanece confirmada.
        }
      }

      if (!mounted) return;

      final messenger = ScaffoldMessenger.of(context);

      // 6. Regresar al catálogo.
      context.go('/home');

      messenger.showSnackBar(
        const SnackBar(
          content: Text('Producto eliminado correctamente'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (_) {
      if (mounted) {
        _message('No se pudo eliminar el producto.');
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  // ============================================================
  // VISTA PREVIA DE IMÁGENES
  // ============================================================

  Widget _preview(_ProductPhoto photo) {
    if (photo.file != null || photo.path != null) {
      return Image.file(
        File(photo.file?.path ?? photo.path!),
        fit: BoxFit.contain,
        errorBuilder: (_, error, stackTrace) {
          return const Icon(
            Icons.broken_image_outlined,
            color: AppColors.textSecondary,
            size: 36,
          );
        },
      );
    }

    return Image.network(
      photo.url!,
      fit: BoxFit.contain,
      errorBuilder: (_, error, stackTrace) {
        return const Icon(
          Icons.broken_image_outlined,
          color: AppColors.textSecondary,
          size: 36,
        );
      },
    );
  }

  // ============================================================
  // DECORACIÓN DE CAMPOS
  // ============================================================

  InputDecoration _decoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _label(String text, {bool required = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        required ? '$text *' : text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  // ============================================================
  // SECCIÓN: IMAGEN PRINCIPAL
  // ============================================================

  Widget _mainImageSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          if (_mainPhoto != null)
            Container(
              width: double.infinity,
              height: 190,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: _preview(_mainPhoto!),
            )
          else
            const Column(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Color(0xFFDCEEE6),
                  child: Icon(
                    Icons.add_a_photo_outlined,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Agregar imagen del producto',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),

          const SizedBox(height: 14),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: _saving ? null : _pickMainImage,
                icon: const Icon(Icons.photo_library_outlined),
                label: const Text('Galería'),
              ),
              OutlinedButton.icon(
                onPressed: _saving ? null : _setMainUrl,
                icon: const Icon(Icons.link_rounded),
                label: const Text('Desde URL'),
              ),
            ],
          ),

          if (_mainPhoto != null)
            TextButton.icon(
              onPressed: _saving
                  ? null
                  : () {
                      setState(() {
                        _mainPhoto = null;
                      });
                    },
              icon: const Icon(Icons.delete_outline),
              label: const Text('Quitar imagen'),
              style: TextButton.styleFrom(foregroundColor: Colors.red.shade700),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // FILA DE NUTRIENTE
  // ============================================================

  Widget _nutrientRow(_NutrientDraft row) {
    return Container(
      key: ObjectKey(row),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6F3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Nutriente',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                onPressed: _saving ? null : () => _removeNutrient(row),
                icon: const Icon(Icons.close_rounded, color: Colors.redAccent),
              ),
            ],
          ),

          TextFormField(
            controller: row.nameController,
            decoration: _decoration('Ej. Proteínas'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Ingresa un nutriente';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  controller: row.amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                  ],
                  decoration: _decoration('Cantidad'),
                  validator: (value) {
                    final text = (value ?? '').trim();

                    if (!RegExp(r'^\d+(?:[.,]\d+)?$').hasMatch(text)) {
                      return 'Valor inválido';
                    }

                    return null;
                  },
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: row.unit,
                  decoration: _decoration('Unidad'),
                  items: _units.map((unit) {
                    return DropdownMenuItem(value: unit, child: Text(unit));
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      row.unit = value;
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECCIÓN: INFORMACIÓN NUTRICIONAL
  // ============================================================

  Widget _nutritionSection() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Información nutricional',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
          ),

          const SizedBox(height: 8),

          const Text(
            'Registra nutrientes escritos, fotografías '
            'o ambas opciones.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),

          const SizedBox(height: 20),

          _label('Valores expresados por'),

          DropdownButtonFormField<String>(
            key: ValueKey(_reference),
            initialValue: _reference,
            isExpanded: true,
            decoration: _decoration('Referencia'),
            items: _references.map((value) {
              return DropdownMenuItem(value: value, child: Text(value));
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _reference = value);
              }
            },
          ),

          if (_reference == 'Por porción') ...[
            const SizedBox(height: 10),

            TextFormField(
              controller: _servingController,
              decoration: _decoration('Ej. 50 g'),
              validator: (value) {
                if (_nutrients.isNotEmpty &&
                    (value == null || value.trim().isEmpty)) {
                  return 'Indica el tamaño de la porción';
                }
                return null;
              },
            ),
          ],

          const SizedBox(height: 18),

          const Text(
            'Tabla nutricional escrita',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 12),

          ..._nutrients.map(_nutrientRow),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _saving ? null : _addNutrient,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Agregar nutriente'),
            ),
          ),

          const SizedBox(height: 18),
          const Divider(),
          const SizedBox(height: 14),

          const Text(
            'Fotografías nutricionales',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 10),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: _saving ? null : _pickNutritionImages,
                icon: const Icon(Icons.photo_library_outlined),
                label: const Text('Galería'),
              ),
              OutlinedButton.icon(
                onPressed: _saving ? null : _addNutritionUrl,
                icon: const Icon(Icons.link_rounded),
                label: const Text('Desde URL'),
              ),
            ],
          ),

          if (_nutritionPhotos.isNotEmpty) ...[
            const SizedBox(height: 14),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(_nutritionPhotos.length, (index) {
                return SizedBox(
                  width: 100,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 105,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F5F2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: _preview(_nutritionPhotos[index]),
                          ),

                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton.filled(
                              onPressed: _saving
                                  ? null
                                  : () {
                                      setState(() {
                                        _nutritionPhotos.removeAt(index);
                                      });
                                    },
                              icon: const Icon(Icons.close, size: 14),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(26, 26),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 5),

                      Text(
                        'Imagen ${index + 1}',
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ],
      ),
    );
  }

  // ============================================================
  // INTERFAZ PRINCIPAL
  // ============================================================

  @override
  Widget build(BuildContext context) {
    // Pantalla de carga durante la edición.
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Error de carga.
    if (_loadError != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Editar producto')),
        body: Center(child: Text(_loadError!)),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,

      // BARRA SUPERIOR
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/petfood_app_icon.png',
              width: 27,
              height: 27,
            ),
            const SizedBox(width: 8),
            Text(
              widget.isEditing ? 'Editar producto' : 'Agregar producto',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),

      // FORMULARIO
      body: SafeArea(
        child: AbsorbPointer(
          absorbing: _saving,
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
              children: [
                // ============================================
                // IDENTIFICACIÓN
                // ============================================

                if (widget.isEditing)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.inventory_2_outlined,
                          color: AppColors.primary,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'ID Catálogo: #${widget.productId}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        const Spacer(),
                        const Text(
                          'En catálogo',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      '● REGISTRO DE CATÁLOGO',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                // ============================================
                // FOTOGRAFÍA PRINCIPAL
                // ============================================
                _label('Fotografía del producto', required: true),

                _mainImageSection(),

                const SizedBox(height: 22),

                // ============================================
                // NOMBRE
                // ============================================
                _label('Nombre del producto', required: true),

                TextFormField(
                  controller: _nameController,
                  maxLength: 80,
                  decoration: _decoration('Ej. Royal Canin Medium Adult 15 kg'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa el nombre del producto';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                // ============================================
                // CATEGORÍA
                // ============================================
                _label('Categoría', required: true),

                DropdownButtonFormField<String>(
                  key: ValueKey(_category),
                  initialValue: _category,
                  isExpanded: true,
                  decoration: _decoration('Seleccionar categoría'),
                  items: _categories.map((value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _category = value);
                  },
                  validator: (value) {
                    return value == null ? 'Selecciona una categoría' : null;
                  },
                ),

                const SizedBox(height: 14),

                // ============================================
                // CATEGORÍAS RÁPIDAS
                // ============================================
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 7),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: _category == category,
                          showCheckmark: false,
                          selectedColor: AppColors.primary,
                          labelStyle: TextStyle(
                            color: _category == category
                                ? Colors.white
                                : AppColors.textPrimary,
                          ),
                          onSelected: (_) {
                            setState(() {
                              _category = category;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 18),

                // ============================================
                // DESCRIPCIÓN
                // ============================================
                _label('Descripción'),

                TextFormField(
                  controller: _descriptionController,
                  maxLength: 500,
                  maxLines: 4,
                  decoration: _decoration('Describe el alimento...'),
                ),

                const SizedBox(height: 14),

                // ============================================
                // PRECIO Y PRESENTACIÓN
                // ============================================
                Row(
                  children: [
                    Expanded(child: _label('Precio', required: true)),
                    const SizedBox(width: 12),
                    Expanded(child: _label('Presentación')),
                  ],
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        decoration: _decoration('54.990')
                            .copyWith(prefixText: '\$ '),
                        validator: (value) {
                          final digits = (value ?? '').replaceAll(
                            RegExp(r'[^0-9]'),
                            '',
                          );

                          final amount = double.tryParse(digits);

                          if (amount == null || amount <= 0) {
                            return 'Precio inválido';
                          }

                          return null;
                        },
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: TextFormField(
                        controller: _presentationController,
                        maxLength: 40,
                        decoration: _decoration('Ej. 15 kg')
                            .copyWith(counterText: ''),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // ============================================
                // INFORMACIÓN NUTRICIONAL
                // ============================================
                _nutritionSection(),

                const SizedBox(height: 22),

                // ============================================
                // INFORMACIÓN LOCAL
                // ============================================
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.beige,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    widget.isEditing
                        ? 'Los cambios se guardarán en este '
                              'dispositivo y se reflejarán en el catálogo.'
                        : 'El producto se guardará localmente '
                              'en este dispositivo.',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),

                // ============================================
                // ELIMINAR PRODUCTO
                // SOLO VISIBLE EN MODO EDICIÓN
                // ============================================
                if (widget.isEditing) ...[
                  const SizedBox(height: 20),

                  OutlinedButton.icon(
                    onPressed: _saving ? null : _deleteProduct,
                    icon: const Icon(Icons.delete_outline_rounded),
                    label: const Text('Eliminar producto'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red.shade700,
                      side: BorderSide(color: Colors.red.shade200),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),

      // ========================================================
      // BOTONES FIJOS INFERIORES
      // ========================================================
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(18, 8, 18, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // GUARDAR PRODUCTO / CAMBIOS
            SizedBox(
              height: 52,
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _saving ? null : _save,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                icon: _saving
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.save_outlined),
                label: Text(
                  _saving
                      ? 'Guardando...'
                      : widget.isEditing
                      ? 'Guardar cambios'
                      : 'Guardar producto',
                ),
              ),
            ),

            // CANCELAR EDICIÓN
            if (widget.isEditing)
              TextButton(
                onPressed: _saving
                    ? null
                    : () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/home');
                        }
                      },
                child: const Text('Cancelar'),
              ),
          ],
        ),
      ),
    );
  }
}
