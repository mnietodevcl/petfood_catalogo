import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/theme/app_colors.dart';
import '../data/product_providers.dart';
import '../data/product_repository.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  static const _categories = [
    'Todos',
    'Perros',
    'Gatos',
    'Cachorros',
    'Gatitos',
    'Adultos',
    'Senior',
  ];

  String _search = '';
  String _category = 'Todos';
  ProductSortOrder _sortOrder = ProductSortOrder.relevance;

  String get _sortLabel {
    switch (_sortOrder) {
      case ProductSortOrder.relevance:
        return 'Relevancia';
      case ProductSortOrder.lowestPrice:
        return 'Menor precio';
      case ProductSortOrder.highestPrice:
        return 'Mayor precio';
      case ProductSortOrder.name:
        return 'Nombre';
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName?.trim() ?? '';

    final firstName = displayName.isEmpty
        ? 'Usuario'
        : displayName.split(RegExp(r'\s+')).first;

    final productsState = ref.watch(productsProvider);
    final repository = ref.read(productRepositoryProvider);

    return Scaffold(
      backgroundColor: AppColors.background,

      // BARRA SUPERIOR
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        titleSpacing: 18,
        title: Row(
          children: [
            IconButton.filledTonal(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  SystemNavigator.pop();
                }
              },
              icon: const Icon(Icons.arrow_back_rounded),
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xFFF0F0ED),
                foregroundColor: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/images/petfood_app_icon.png',
                width: 28,
                height: 28,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Catálogo',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          _ProfileAvatar(photoUrl: user?.photoURL),
          const SizedBox(width: 18),
        ],
      ),

      // CONTENIDO
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SALUDO PERSONALIZADO
            Padding(
              padding: const EdgeInsets.fromLTRB(26, 12, 26, 18),
              child: Text(
                '¡Hola, $firstName!',
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
            ),

            // BUSCADOR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: TextField(
                onChanged: (value) {
                  setState(() => _search = value);
                },
                decoration: InputDecoration(
                  hintText: 'Buscar alimento para mascotas...',
                  hintStyle: const TextStyle(fontSize: 13),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.primary,
                  ),
                  suffixIcon: PopupMenuButton<ProductSortOrder>(
                    tooltip: 'Ordenar productos',
                    icon: const Icon(Icons.tune_rounded, size: 20),
                    onSelected: (value) {
                      setState(() => _sortOrder = value);
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: ProductSortOrder.relevance,
                        child: Text('Relevancia'),
                      ),
                      PopupMenuItem(
                        value: ProductSortOrder.lowestPrice,
                        child: Text('Menor precio'),
                      ),
                      PopupMenuItem(
                        value: ProductSortOrder.highestPrice,
                        child: Text('Mayor precio'),
                      ),
                      PopupMenuItem(
                        value: ProductSortOrder.name,
                        child: Text('Nombre'),
                      ),
                    ],
                  ),
                  fillColor: const Color(0xFFF6F6F2),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 13),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // CATEGORÍAS
            SizedBox(
              height: 42,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final selected = _category == category;

                  return ChoiceChip(
                    label: Text(category),
                    selected: selected,
                    showCheckmark: false,
                    onSelected: (_) {
                      setState(() => _category = category);
                    },
                    avatar: category == 'Todos'
                        ? Icon(
                            Icons.pets_rounded,
                            size: 16,
                            color: selected ? Colors.white : AppColors.primary,
                          )
                        : null,
                    selectedColor: AppColors.primary,
                    backgroundColor: Colors.white,
                    side: BorderSide.none,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : AppColors.textPrimary,
                      fontWeight: selected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // PRODUCTOS DESDE SQLITE
            Expanded(
              child: productsState.when(
                loading: () => const Center(child: CircularProgressIndicator()),

                error: (error, _) => _CatalogMessage(
                  icon: Icons.error_outline,
                  title: 'No pudimos cargar el catálogo',
                  description:
                      'Ocurrió un problema al consultar los productos.',
                  buttonText: 'Reintentar',
                  onPressed: () => ref.invalidate(productsProvider),
                ),

                data: (products) {
                  final visibleProducts = repository.filterProducts(
                    products,
                    search: _search,
                    category: _category,
                    sortOrder: _sortOrder,
                  );

                  return Column(
                    children: [
                      // CONTADOR Y ORDENAMIENTO
                      Padding(
                        padding: const EdgeInsets.fromLTRB(26, 0, 20, 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'MOSTRANDO ${visibleProducts.length} RESULTADOS',
                                style: const TextStyle(
                                  fontSize: 10,
                                  letterSpacing: 0.7,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                            Text(
                              _sortLabel,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 16,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),

                      // GRILLA O ESTADO VACÍO
                      Expanded(
                        child: visibleProducts.isEmpty
                            ? _CatalogMessage(
                                icon: products.isEmpty
                                    ? Icons.inventory_2_outlined
                                    : Icons.search_off_rounded,
                                title: products.isEmpty
                                    ? 'Aún no tienes productos'
                                    : 'No encontramos productos',
                                description: products.isEmpty
                                    ? 'Agrega tu primer alimento para comenzar a crear tu catálogo.'
                                    : 'Prueba buscando por otro nombre o categoría.',
                                buttonText: products.isEmpty
                                    ? 'Agregar producto'
                                    : null,
                                onPressed: products.isEmpty
                                    ? () => context.push('/product/add')
                                    : null,
                              )
                            : LayoutBuilder(
                                builder: (context, constraints) {
                                  final width = constraints.maxWidth;

                                  final columns = width >= 740
                                      ? 4
                                      : width >= 520
                                      ? 3
                                      : 2;

                                  return GridView.builder(
                                    padding: const EdgeInsets.fromLTRB(
                                      26,
                                      0,
                                      26,
                                      100,
                                    ),
                                    itemCount: visibleProducts.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: columns,
                                          crossAxisSpacing: 12,
                                          mainAxisSpacing: 16,
                                          mainAxisExtent: 224,
                                        ),
                                    itemBuilder: (context, index) {
                                      return _ProductCard(
                                        product: visibleProducts[index],
                                      );
                                    },
                                  );
                                },
                              ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // BOTÓN FLOTANTE
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/product/add'),
        shape: const CircleBorder(),
        tooltip: 'Agregar producto',
        child: const Icon(Icons.add_rounded, size: 34),
      ),
    );
  }
}

// AVATAR DEL USUARIO

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.photoUrl});

  final String? photoUrl;
  final double size = 36;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/profile'),
      customBorder: const CircleBorder(),
      child: SizedBox(
        width: size + 4,
        height: size + 4,
        child: Stack(
          children: [
            Container(
              width: size,
              height: size,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.beige,
                border: Border.all(color: AppColors.primary, width: 1),
              ),
              child: ClipOval(
                child: photoUrl != null && photoUrl!.isNotEmpty
                    ? Image.network(
                        photoUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) =>
                            const Icon(Icons.person_rounded),
                      )
                    : const Icon(Icons.person_rounded),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 1,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.background, width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TARJETA DE PRODUCTO
class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    void openProduct() {
      context.push('/product/${product.id}');
    }

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: openProduct,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // IMAGEN
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: const Color(0xFFF3F4F2),
                      padding: const EdgeInsets.all(12),
                      child: _ProductImage(product: product),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.beige,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        product.category,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // NOMBRE Y PRECIO
            SizedBox(
              height: 104,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(11, 10, 10, 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          height: 1.16,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _formatPrice(product.price),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        IconButton.filledTonal(
                          onPressed: openProduct,
                          tooltip: 'Ver producto',
                          icon: const Icon(Icons.add_rounded, size: 19),
                          style: IconButton.styleFrom(
                            backgroundColor: const Color(0xFFA8EBCB),
                            foregroundColor: AppColors.primary,
                            minimumSize: const Size(32, 32),
                            maximumSize: const Size(32, 32),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// IMAGEN LOCAL O HTTPS
class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final path = product.productImagePath;
    final url = product.productImageUrl;

    if (path != null && path.isNotEmpty) {
      return Image.file(
        File(path),
        fit: BoxFit.contain,
        errorBuilder: (_, _, _) => _placeholder(),
      );
    }

    if (url != null && Uri.tryParse(url)?.scheme == 'https') {
      return Image.network(
        url,
        fit: BoxFit.contain,
        errorBuilder: (_, _, _) => _placeholder(),
      );
    }

    return _placeholder();
  }

  Widget _placeholder() {
    return const Center(
      child: Icon(Icons.pets_rounded, size: 40, color: AppColors.primary),
    );
  }
}

// MENSAJES VACÍOS Y ERRORES
class _CatalogMessage extends StatelessWidget {
  const _CatalogMessage({
    required this.icon,
    required this.title,
    required this.description,
    this.buttonText,
    this.onPressed,
  });

  final IconData icon;
  final String title;
  final String description;
  final String? buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.beige,
              child: Icon(icon, size: 38, color: AppColors.primary),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            if (buttonText != null && onPressed != null) ...[
              const SizedBox(height: 18),
              FilledButton.icon(
                onPressed: onPressed,
                icon: const Icon(Icons.add),
                label: Text(buttonText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// FORMATO DE PESOS CHILENOS
String _formatPrice(double price) {
  final digits = price.round().toString();

  final formatted = digits.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => '.',
  );

  return '\$$formatted';
}
