import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:petfood_catalogo/core/database/app_database.dart';

void main() {
  test('Migración de versión 1 a 2 conserva productos e imágenes', () async {
    // Simular una base de datos antigua (versión 1).
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
              updated_at INTEGER NOT NULL
            )
          ''');

        // Dos productos antiguos con diferentes
        // tipos de imágenes nutricionales.
        sqlite.execute('''
            INSERT INTO products (
              id,
              name,
              category,
              description,
              price,
              product_image_path,
              product_image_url,
              nutrition_image_path,
              nutrition_image_url,
              created_at,
              updated_at
            ) VALUES
            (
              1,
              'Royal Canin Adult',
              'Perros',
              'Alimento para perros adultos',
              45990,
              NULL,
              'https://example.com/producto.jpg',
              'nutricion_antigua.jpg',
              NULL,
              1760000000,
              1760000000
            ),
            (
              2,
              'Purina One Gatos',
              'Gatos',
              'Alimento para gatos adultos',
              21990,
              NULL,
              NULL,
              NULL,
              'https://example.com/nutricion.jpg',
              1760000000,
              1760000000
            )
          ''');

        // Marcar SQLite como versión 1.
        sqlite.execute('PRAGMA user_version = 1');
      },
    );

    final database = AppDatabase(executor);

    try {
      // Abrir la base ejecuta la migración automáticamente.
      final products = await database.getAllProducts();

      // 1. Los productos antiguos siguen existiendo.
      expect(products.length, 2);

      final firstProduct = await database.getProductById(1);

      expect(firstProduct, isNotNull);
      expect(firstProduct!.name, 'Royal Canin Adult');
      expect(firstProduct.price, 45990);
      expect(firstProduct.presentation, isNull);

      // 2. Se creó la nueva tabla de imágenes.
      final images = await database
          .select(database.productNutritionImages)
          .get();

      expect(images.length, 2);

      // 3. La imagen local antigua se conservó.
      final localImage = images.singleWhere((image) => image.productId == 1);

      expect(localImage.imagePath, 'nutricion_antigua.jpg');
      expect(localImage.sortOrder, 0);

      // 4. La imagen por URL también se conservó.
      final urlImage = images.singleWhere((image) => image.productId == 2);

      expect(urlImage.imageUrl, 'https://example.com/nutricion.jpg');

      // 5. La versión de SQLite ahora es 2.
      final version = await database
          .customSelect('PRAGMA user_version')
          .getSingle();

      expect(version.read<int>('user_version'), 3);

      // 6. Al eliminar un producto,
      // también se eliminan sus imágenes relacionadas.
      final deleted = await database.deleteProduct(1);

      expect(deleted, isTrue);

      final remainingImages = await database
          .select(database.productNutritionImages)
          .get();

      expect(remainingImages.length, 1);
      expect(remainingImages.first.productId, 2);
    } finally {
      await database.close();
    }
  });
}
