
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/products.dart';
import 'tables/product_nutrition_images.dart';
import 'tables/product_nutrition_values.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Products,
    ProductNutritionImages,
    ProductNutritionValues,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(
          executor ?? driftDatabase(name: 'petfood_catalogo'),
        );

  // VERSIÓN ACTUAL DE SQLITE
  @override
  int get schemaVersion => 3;

  // MIGRACIONES

  @override
  MigrationStrategy get migration => MigrationStrategy(
        // Primera instalación: crear todas las tablas.
        onCreate: (m) async {
          await m.createAll();
        },

        // Actualizar instalaciones existentes.
        onUpgrade: (m, from, to) async {

          // MIGRACIÓN V1 -> V2
          if (from < 2) {
            // Agregar presentación comercial.
            await m.addColumn(
              products,
              products.presentation,
            );

            // Crear tabla de fotografías nutricionales.
            await m.createTable(productNutritionImages);

            // Conservar las fotografías antiguas.
            await customStatement('''
              INSERT INTO product_nutrition_images
                (product_id, image_path, image_url, sort_order)
              SELECT
                id,
                nutrition_image_path,
                nutrition_image_url,
                0
              FROM products
              WHERE
                (nutrition_image_path IS NOT NULL
                  AND nutrition_image_path != '')
                OR
                (nutrition_image_url IS NOT NULL
                  AND nutrition_image_url != '')
            ''');
          }

          // MIGRACIÓN V2 -> V3
          if (from < 3) {
            // Crear tabla de valores nutricionales escritos.
            await m.createTable(productNutritionValues);
          }
        },

        // Habilitar claves foráneas.
        beforeOpen: (details) async {
          await customStatement(
            'PRAGMA foreign_keys = ON',
          );
        },
      );

  // CONSULTAR TODOS LOS PRODUCTOS
  Future<List<Product>> getAllProducts() {
    return select(products).get();
  }
  // CONSULTAR PRODUCTO POR ID

  Future<Product?> getProductById(int id) {
    return (select(products)
          ..where((product) => product.id.equals(id)))
        .getSingleOrNull();
  }

  // CREAR PRODUCTO

  Future<int> createProduct(ProductsCompanion product) {
    return into(products).insert(product);
  }

  // ACTUALIZAR PRODUCTO

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

  // ELIMINAR PRODUCTO

  Future<bool> deleteProduct(int id) async {
    final deletedRows = await (delete(products)
          ..where((product) => product.id.equals(id)))
        .go();

    return deletedRows > 0;
  }
}
