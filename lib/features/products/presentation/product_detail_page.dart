import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/theme/app_colors.dart';
import '../data/product_providers.dart';

// ============================================================
// DATOS NUTRICIONALES
// ============================================================

class _NutritionContent {
  const _NutritionContent({required this.images, required this.values});

  final List<ProductNutritionImage> images;
  final List<ProductNutritionValue> values;
}

// ============================================================
// PANTALLA DETALLE DE PRODUCTO
// ============================================================

class ProductDetailPage extends ConsumerStatefulWidget {
  const ProductDetailPage({super.key, required this.productId});

  final String productId;

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  late Future<_NutritionContent> _nutritionFuture;

  @override
  void initState() {
    super.initState();
    _nutritionFuture = _loadNutrition();
  }

  @override
  void didUpdateWidget(covariant ProductDetailPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.productId != widget.productId) {
      _nutritionFuture = _loadNutrition();
    }
  }

  // ==========================================================
  // CONSULTAR FOTOGRAFÍAS Y NUTRIENTES DESDE SQLITE
  // ==========================================================

  Future<_NutritionContent> _loadNutrition() async {
    final id = int.tryParse(widget.productId);

    if (id == null) {
      return const _NutritionContent(images: [], values: []);
    }

    final repository = ref.read(productRepositoryProvider);

    final images = await repository.getNutritionImages(id);
    final values = await repository.getNutritionValues(id);

    return _NutritionContent(images: images, values: values);
  }

  // ==========================================================
  // NAVEGACIÓN
  // ==========================================================

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/home');
    }
  }

  Future<void> _editProduct(int id) async {
    await context.push<void>('/product/$id/edit');

    if (!mounted) return;

    setState(() {
      _nutritionFuture = _loadNutrition();
    });
  }

  // ==========================================================
  // AMPLIAR FOTOGRAFÍA
  // ==========================================================

  void _openImage({String? path, String? url}) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final screen = MediaQuery.sizeOf(dialogContext);

        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.all(12),
          child: SizedBox(
            width: screen.width * 0.95,
            height: screen.height * 0.72,
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          'Fotografía del producto',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                const Divider(height: 1),
                Expanded(
                  child: InteractiveViewer(
                    minScale: 0.8,
                    maxScale: 4,
                    child: Center(
                      child: _ProductPhoto(path: path, url: url),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==========================================================
  // INTERFAZ PRINCIPAL
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productsProvider);
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,

      floatingActionButton: productsState.when(
        data: (products) {
          final id = int.tryParse(widget.productId);

          if (id == null || !products.any((product) => product.id == id)) {
            return null;
          }

          return FloatingActionButton(
            onPressed: () => _editProduct(id),
            tooltip: 'Editar producto',
            shape: const CircleBorder(),
            child: const Icon(Icons.edit_rounded, size: 26),
          );
        },
        loading: () => null,
        error: (error, stackTrace) => null,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // BARRA SUPERIOR
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: Row(
          children: [
            IconButton.filledTonal(
              onPressed: _goBack,
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xFFF0F0ED),
                foregroundColor: AppColors.textPrimary,
              ),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            const SizedBox(width: 8),
            Image.asset(
              'assets/images/petfood_app_icon.png',
              width: 29,
              height: 29,
            ),
            const SizedBox(width: 9),
            const Expanded(
              child: Text(
                'Detalle de producto',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () => context.push('/profile'),
            customBorder: const CircleBorder(),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primary,
              child: ClipOval(
                child: user?.photoURL != null && user!.photoURL!.isNotEmpty
                    ? Image.network(
                        user.photoURL!,
                        width: 35,
                        height: 35,
                        fit: BoxFit.cover,
                        errorBuilder: (_, error, stack) {
                          return const Icon(
                            Icons.person_rounded,
                            color: Colors.white,
                          );
                        },
                      )
                    : const Icon(Icons.person_rounded, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),

      // CONTENIDO
      body: productsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (error, stackTrace) => _message(
          icon: Icons.error_outline,
          title: 'No se pudo cargar el producto',
          description: 'Inténtalo nuevamente.',
        ),

        data: (products) {
          final id = int.tryParse(widget.productId);

          Product? product;

          for (final item in products) {
            if (item.id == id) {
              product = item;
              break;
            }
          }

          if (product == null) {
            return _message(
              icon: Icons.inventory_2_outlined,
              title: 'Producto no encontrado',
              description: 'El producto no existe o fue eliminado.',
            );
          }

          return Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 680),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildHero(product),
                          const SizedBox(height: 18),
                          _buildProductHeading(product),
                          const SizedBox(height: 18),
                          _buildProductFacts(product),
                          const SizedBox(height: 16),
                          _buildDescription(product),
                          const SizedBox(height: 16),
                          _buildNutritionDetails(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ============================================================
  // FOTOGRAFÍA PRINCIPAL
  // ============================================================

  Widget _buildHero(Product product) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xFFE9F8EF)],
          begin: Alignment.centerLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEBEEE9)),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 15,
            right: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, size: 7, color: AppColors.primary),
                  SizedBox(width: 6),
                  Text(
                    'En catálogo',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 48, 30, 42),
              child: InkWell(
                onTap: () => _openImage(
                  path: product.productImagePath,
                  url: product.productImageUrl,
                ),
                child: _ProductPhoto(
                  path: product.productImagePath,
                  url: product.productImageUrl,
                ),
              ),
            ),
          ),

          const Positioned(
            left: 16,
            bottom: 14,
            child: Row(
              children: [
                Icon(
                  Icons.zoom_in_rounded,
                  size: 17,
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: 5),
                Text(
                  'Toca para ampliar',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // NOMBRE, CATEGORÍA Y PRECIO
  // ============================================================

  Widget _buildProductHeading(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.beige,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.pets_rounded,
                color: AppColors.primary,
                size: 15,
              ),
              const SizedBox(width: 6),
              Text(
                product.category,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        Text(
          product.name,
          style: const TextStyle(
            fontSize: 21,
            height: 1.2,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          _formatPrice(product.price),
          style: const TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // CARACTERÍSTICAS DEL PRODUCTO
  // ============================================================

  Widget _buildProductFacts(Product product) {
    final presentation = product.presentation?.trim().isNotEmpty == true
        ? product.presentation!.trim()
        : 'Sin indicar';

    return Row(
      children: [
        Expanded(
          child: _FactCard(
            icon: Icons.inventory_2_outlined,
            label: 'Formato',
            value: presentation,
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: _FactCard(
            icon: Icons.pets_outlined,
            label: 'Categoría',
            value: product.category,
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: _FactCard(
            icon: Icons.calendar_month_outlined,
            label: 'Registrado',
            value: _formatDate(product.createdAt),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DESCRIPCIÓN
  // ============================================================

  Widget _buildDescription(Product product) {
    final description = product.description.trim();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Descripción',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                ),
              ),
              Icon(
                Icons.menu_book_outlined,
                color: AppColors.primary,
                size: 21,
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            description.isEmpty ? 'Sin descripción registrada.' : description,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CARGAR INFORMACIÓN NUTRICIONAL
  // ============================================================

  Widget _buildNutritionDetails() {
    return FutureBuilder<_NutritionContent>(
      future: _nutritionFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _nutritionFuture = _loadNutrition();
                });
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar información nutricional'),
            ),
          );
        }

        final content = snapshot.data;

        if (content == null ||
            (content.images.isEmpty && content.values.isEmpty)) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.monitor_heart_outlined,
                    color: AppColors.primary,
                    size: 23,
                  ),
                  SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      'Información nutricional',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),

              if (content.values.isNotEmpty) ...[
                const SizedBox(height: 18),
                _buildNutritionTable(content.values),
              ],

              if (content.images.isNotEmpty) ...[
                if (content.values.isNotEmpty) ...[
                  const SizedBox(height: 18),
                  const Divider(),
                ],

                const SizedBox(height: 14),

                const Text(
                  'Fotografías nutricionales',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),

                const SizedBox(height: 12),

                _buildNutritionGallery(content.images),
              ],
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // TABLA NUTRICIONAL ESCRITA
  // ============================================================

  Widget _buildNutritionTable(List<ProductNutritionValue> nutrients) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Composición nutricional',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),

        const SizedBox(height: 10),

        ...nutrients.map((nutrient) {
          final reference = nutrient.referenceBasis;

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 12),
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8F6),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nutrient.nutrientName,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      if (reference != null && reference.isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          reference,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                Text(
                  '${_formatAmount(nutrient.amount)} '
                  '${nutrient.unit}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // ============================================================
  // GALERÍA DE FOTOGRAFÍAS NUTRICIONALES
  // ============================================================

  Widget _buildNutritionGallery(List<ProductNutritionImage> images) {
    return Wrap(
      spacing: 10,
      runSpacing: 12,
      children: List.generate(images.length, (index) {
        final image = images[index];

        return InkWell(
          onTap: () => _openImage(path: image.imagePath, url: image.imageUrl),
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 100,
                height: 105,
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE8EAE7)),
                ),
                child: _ProductPhoto(
                  path: image.imagePath,
                  url: image.imageUrl,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                'Imagen ${index + 1}',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // ============================================================
  // PRODUCTO NO DISPONIBLE
  // ============================================================

  Widget _message({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 52, color: AppColors.primary),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Volver al catálogo'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// WIDGET REUTILIZABLE: IMAGEN LOCAL O URL
// ============================================================

class _ProductPhoto extends StatelessWidget {
  const _ProductPhoto({this.path, this.url});

  final String? path;
  final String? url;

  @override
  Widget build(BuildContext context) {
    if (path != null && path!.isNotEmpty) {
      return Image.file(
        File(path!),
        fit: BoxFit.contain,
        errorBuilder: (_, error, stackTrace) {
          return _placeholder();
        },
      );
    }

    if (url != null && Uri.tryParse(url!)?.scheme == 'https') {
      return Image.network(
        url!,
        fit: BoxFit.contain,
        errorBuilder: (_, error, stackTrace) {
          return _placeholder();
        },
      );
    }

    return _placeholder();
  }

  Widget _placeholder() {
    return const Center(
      child: Icon(Icons.pets_rounded, size: 48, color: AppColors.primary),
    );
  }
}

// ============================================================
// WIDGET REUTILIZABLE: TARJETA DE CARACTERÍSTICA
// ============================================================

class _FactCard extends StatelessWidget {
  const _FactCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: AppColors.beige,
            child: Icon(icon, size: 18, color: AppColors.primary),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// FORMATO DE PRECIO CHILENO
// ============================================================

String _formatPrice(double price) {
  final digits = price.round().toString();

  final formatted = digits.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => '.',
  );

  return '\$$formatted';
}

// ============================================================
// FORMATO DE VALORES NUTRICIONALES
// ============================================================

String _formatAmount(double amount) {
  final text = amount.toString();

  if (text.endsWith('.0')) {
    return text.substring(0, text.length - 2);
  }

  return text.replaceAll('.', ',');
}

// ============================================================
// FORMATO DE FECHA
// ============================================================

String _formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  final year = date.year.toString();

  return '$day/$month/$year';
}
