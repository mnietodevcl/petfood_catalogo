import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:petfood_catalogo/core/database/app_database.dart';

void main() {
  test('Migración V2 a V3 conserva productos y permite nutrientes', () async {
    // Simular una base de datos existente en versión 2.
    final executor = NativeDatabase.memory(
      setup: (sqlite) {
        sqlite.execute('''
            CREATE TABLE products (
              id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              category TEXT NOT NULL,
              description TEXT NOT NULL,
              price REAL NOT NULL,
              product_image_path TEXT,
              product_image_url TEXT,
              nutrition_image_path TEXT,
              nutrition_image_url TEXT,
              created_at INTEGER NOT NULL,
              updated_at INTEGER NOT NULL,
              presentation TEXT
            )
          ''');

        sqlite.execute('''
            CREATE TABLE product_nutrition_images (
              id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
              product_id INTEGER NOT NULL
                REFERENCES products(id) ON DELETE CASCADE,
              image_path TEXT,
              image_url TEXT,
              sort_order INTEGER NOT NULL DEFAULT 0
            )
          ''');

        // Producto existente.
        sqlite.execute('''
            INSERT INTO products (
              id, name, category, description, price,
              created_at, updated_at, presentation
            ) VALUES (
              1, 'Pedigree Adulto', 'Perros',
              'Alimento para perros adultos', 33900,
              1760000000, 1760000000, '15 kg'
            )
          ''');

        // Fotografía nutricional existente.
        sqlite.execute('''
            INSERT INTO product_nutrition_images (
              product_id, image_url, sort_order
            ) VALUES (
              1, 'https://example.com/nutricion.jpg', 0
            )
          ''');

        // Indicar que es una base versión 2.
        sqlite.execute('PRAGMA user_version = 2');
      },
    );

    final database = AppDatabase(executor);

    try {
      // Abrir y consultar ejecuta la migración.
      final products = await database.getAllProducts();

      // Verificar producto anterior.
      expect(products.length, 1);
      expect(products.first.name, 'Pedigree Adulto');
      expect(products.first.presentation, '15 kg');
      expect(products.first.price, 33900);

      // Verificar fotografía anterior.
      final images = await database
          .select(database.productNutritionImages)
          .get();

      expect(images.length, 1);
      expect(images.first.imageUrl, 'https://example.com/nutricion.jpg');

      // Registrar un nutriente en la tabla nueva.
      await database
          .into(database.productNutritionValues)
          .insert(
            ProductNutritionValuesCompanion.insert(
              productId: 1,
              nutrientName: 'Proteínas',
              amount: 26.0,
              unit: '%',
              referenceBasis: const Value('Análisis garantizado'),
            ),
          );

      // Comprobar el valor nutricional registrado.
      final nutrients = await database
          .select(database.productNutritionValues)
          .get();

      expect(nutrients.length, 1);
      expect(nutrients.first.productId, 1);
      expect(nutrients.first.nutrientName, 'Proteínas');
      expect(nutrients.first.amount, 26.0);
      expect(nutrients.first.unit, '%');
      expect(nutrients.first.referenceBasis, 'Análisis garantizado');

      // Verificar versión final.
      final version = await database
          .customSelect('PRAGMA user_version')
          .getSingle();

      expect(version.read<int>('user_version'), 3);
    } finally {
      await database.close();
    }
  });
}
