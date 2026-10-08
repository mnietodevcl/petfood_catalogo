
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/products.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Products])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(
          executor ?? driftDatabase(name: 'petfood_catalogo'),
        );

  @override
  int get schemaVersion => 1;

  // 1. Obtener todos los productos
  Future<List<Product>> getAllProducts() {
    return select(products).get();
  }

  // 2. Obtener producto por ID
  Future<Product?> getProductById(int id) {
    return (select(products)
          ..where((product) => product.id.equals(id)))
        .getSingleOrNull();
  }

  // 3. Crear un producto
  Future<int> createProduct(ProductsCompanion product) {
    return into(products).insert(product);
  }

  // 4. Actualizar un producto
  Future<bool> updateProduct(
    int id,
    ProductsCompanion changes,
  ) async {
    final updatedRows = await (update(products)
          ..where((product) => product.id.equals(id)))
        .write(
          changes.copyWith(
            id: const Value.absent(),
            createdAt: const Value.absent(),
            updatedAt: Value(DateTime.now()),
          ),
        );

    return updatedRows > 0;
  }

  // 5. Eliminar un producto
  Future<bool> deleteProduct(int id) async {
    final deletedRows = await (delete(products)
          ..where((product) => product.id.equals(id)))
        .go();

    return deletedRows > 0;
  }
}
