import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

// ============================================================
// ORDENAMIENTO DEL CATÁLOGO
// ============================================================

enum ProductSortOrder { relevance, lowestPrice, highestPrice, name }

// ============================================================
// IMÁGENES NUTRICIONALES
// ============================================================

class NutritionImageInput {
  const NutritionImageInput.fromGallery(String path)
    : imagePath = path,
      imageUrl = null;

  const NutritionImageInput.fromUrl(String url)
    : imagePath = null,
      imageUrl = url;

  final String? imagePath;
  final String? imageUrl;
}

// ============================================================
// VALORES NUTRICIONALES
// ============================================================

class NutritionValueInput {
  const NutritionValueInput({
    required this.nutrientName,
    required this.amount,
    required this.unit,
    required this.referenceBasis,
    this.qualifier,
  });

  final String nutrientName;
  final double amount;
  final String unit;
  final String referenceBasis;
  final String? qualifier;
}

// ============================================================
// REPOSITORIO
// ============================================================

class ProductRepository {
  ProductRepository(this._database);

  final AppDatabase _database;

  // ==========================================================
  // CONSULTAR PRODUCTOS
  // ==========================================================

  Stream<List<Product>> watchAllProducts() {
    return (_database.select(
      _database.products,
    )..orderBy([(product) => OrderingTerm.desc(product.createdAt)])).watch();
  }

  Future<List<Product>> getAllProducts() {
    return _database.getAllProducts();
  }

  Future<Product?> getProductById(int id) {
    return _database.getProductById(id);
  }

  // ==========================================================
  // CREAR PRODUCTO SIMPLE
  // ==========================================================

  Future<int> createProduct(ProductsCompanion product) {
    return _database.createProduct(product);
  }

  // ==========================================================
  // CREAR PRODUCTO CON INFORMACIÓN NUTRICIONAL
  // ==========================================================

  Future<int> createProductWithNutrition(
    ProductsCompanion product, {
    List<NutritionImageInput> images = const [],
    List<NutritionValueInput> nutrients = const [],
  }) async {
    return _database.transaction(() async {
      final productId = await _database.createProduct(product);

      for (var i = 0; i < images.length; i++) {
        final image = images[i];

        await _database
            .into(_database.productNutritionImages)
            .insert(
              ProductNutritionImagesCompanion.insert(
                productId: productId,
                imagePath: Value(image.imagePath),
                imageUrl: Value(image.imageUrl),
                sortOrder: Value(i),
              ),
            );
      }

      for (var i = 0; i < nutrients.length; i++) {
        final nutrient = nutrients[i];

        _validateNutrient(nutrient);

        await _database
            .into(_database.productNutritionValues)
            .insert(
              ProductNutritionValuesCompanion.insert(
                productId: productId,
                nutrientName: nutrient.nutrientName.trim(),
                amount: nutrient.amount,
                unit: nutrient.unit.trim(),
                referenceBasis: Value(nutrient.referenceBasis.trim()),
                qualifier: Value(nutrient.qualifier),
                sortOrder: Value(i),
              ),
            );
      }

      return productId;
    });
  }

  // ==========================================================
  // CONSULTAR FOTOGRAFÍAS NUTRICIONALES
  // ==========================================================

  Future<List<ProductNutritionImage>> getNutritionImages(int productId) {
    return (_database.select(_database.productNutritionImages)
          ..where((image) => image.productId.equals(productId))
          ..orderBy([(image) => OrderingTerm.asc(image.sortOrder)]))
        .get();
  }

  // ==========================================================
  // CONSULTAR VALORES NUTRICIONALES
  // ==========================================================

  Future<List<ProductNutritionValue>> getNutritionValues(int productId) {
    return (_database.select(_database.productNutritionValues)
          ..where((value) => value.productId.equals(productId))
          ..orderBy([(value) => OrderingTerm.asc(value.sortOrder)]))
        .get();
  }

  // ==========================================================
  // EDITAR PRODUCTO SIMPLE
  // ==========================================================

  Future<bool> updateProduct(int id, ProductsCompanion changes) {
    return _database.updateProduct(id, changes);
  }

  // ==========================================================
  // EDITAR PRODUCTO CON INFORMACIÓN NUTRICIONAL
  // ==========================================================

  Future<bool> updateProductWithNutrition(
    int productId,
    ProductsCompanion changes, {
    required List<NutritionImageInput> images,
    required List<NutritionValueInput> nutrients,
  }) async {
    // Validar antes de modificar cualquier registro.
    for (final nutrient in nutrients) {
      _validateNutrient(nutrient);
    }

    for (final image in images) {
      final hasPath =
          image.imagePath != null && image.imagePath!.trim().isNotEmpty;

      final hasUrl =
          image.imageUrl != null && image.imageUrl!.trim().isNotEmpty;

      if (hasPath == hasUrl) {
        throw ArgumentError('Cada imagen debe tener una ruta o una URL.');
      }
    }

    return _database.transaction(() async {
      // 1. Verificar que exista el producto.
      final existing = await _database.getProductById(productId);

      if (existing == null) {
        return false;
      }

      // 2. Actualizar datos principales.
      final updated = await _database.updateProduct(productId, changes);

      if (!updated) {
        throw StateError('No se pudo actualizar el producto.');
      }

      // 3. Reemplazar referencias nutricionales.
      // Las listas recibidas deben contener TODOS los
      // registros que se desean conservar.
      await (_database.delete(
        _database.productNutritionImages,
      )..where((image) => image.productId.equals(productId))).go();

      for (var i = 0; i < images.length; i++) {
        final image = images[i];

        await _database
            .into(_database.productNutritionImages)
            .insert(
              ProductNutritionImagesCompanion.insert(
                productId: productId,
                imagePath: Value(image.imagePath),
                imageUrl: Value(image.imageUrl),
                sortOrder: Value(i),
              ),
            );
      }

      // 4. Reemplazar valores nutricionales.
      await (_database.delete(
        _database.productNutritionValues,
      )..where((value) => value.productId.equals(productId))).go();

      for (var i = 0; i < nutrients.length; i++) {
        final nutrient = nutrients[i];

        await _database
            .into(_database.productNutritionValues)
            .insert(
              ProductNutritionValuesCompanion.insert(
                productId: productId,
                nutrientName: nutrient.nutrientName.trim(),
                amount: nutrient.amount,
                unit: nutrient.unit.trim(),
                referenceBasis: Value(nutrient.referenceBasis.trim()),
                qualifier: Value(nutrient.qualifier),
                sortOrder: Value(i),
              ),
            );
      }

      return true;
    });
  }

  // ==========================================================
  // VALIDACIONES NUTRICIONALES
  // ==========================================================

  void _validateNutrient(NutritionValueInput nutrient) {
    if (nutrient.nutrientName.trim().isEmpty ||
        nutrient.unit.trim().isEmpty ||
        nutrient.referenceBasis.trim().isEmpty ||
        !nutrient.amount.isFinite ||
        nutrient.amount < 0) {
      throw ArgumentError('Datos nutricionales inválidos.');
    }
  }

  // ==========================================================
  // ELIMINAR PRODUCTO
  // ==========================================================

  Future<bool> deleteProduct(int id) {
    return _database.deleteProduct(id);
  }

  // ==========================================================
  // BUSCAR, FILTRAR Y ORDENAR PRODUCTOS
  // ==========================================================

  List<Product> filterProducts(
    List<Product> items, {
    String search = '',
    String category = 'Todos',
    ProductSortOrder sortOrder = ProductSortOrder.relevance,
  }) {
    final query = search.trim().toLowerCase();

    final result = items.where((product) {
      final matchesName = product.name.toLowerCase().contains(query);

      final matchesCategory =
          category == 'Todos' ||
          product.category.toLowerCase() == category.toLowerCase();

      return matchesName && matchesCategory;
    }).toList();

    switch (sortOrder) {
      case ProductSortOrder.relevance:
        break;

      case ProductSortOrder.lowestPrice:
        result.sort((a, b) => a.price.compareTo(b.price));

      case ProductSortOrder.highestPrice:
        result.sort((a, b) => b.price.compareTo(a.price));

      case ProductSortOrder.name:
        result.sort(
          (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
        );
    }

    return result;
  }
}
