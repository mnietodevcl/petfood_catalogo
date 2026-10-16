import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:petfood_catalogo/core/database/app_database.dart';
import 'package:petfood_catalogo/features/products/data/product_repository.dart';

void main() {
  group('Repositorio de productos con nutrición', () {
    late AppDatabase database;
    late ProductRepository repository;

    setUp(() {
      database = AppDatabase(NativeDatabase.memory());
      repository = ProductRepository(database);
    });

    tearDown(() async {
      await database.close();
    });

    test('Guarda producto, fotografías y nutrientes', () async {
      final productId = await repository.createProductWithNutrition(
        ProductsCompanion.insert(
          name: 'Alimento Test Nutricional',
          category: 'Perros',
          description: 'Producto de prueba',
          price: 24990,
          presentation: const Value('3 kg'),
          productImageUrl: const Value('https://example.com/producto.jpg'),
        ),
        images: const [
          NutritionImageInput.fromGallery('/imagenes/nutricion.jpg'),
          NutritionImageInput.fromUrl('https://example.com/ingredientes.jpg'),
        ],
        nutrients: const [
          NutritionValueInput(
            nutrientName: 'Proteínas',
            amount: 26,
            unit: '%',
            referenceBasis: 'Análisis garantizado',
          ),
          NutritionValueInput(
            nutrientName: 'Grasas',
            amount: 14,
            unit: '%',
            referenceBasis: 'Análisis garantizado',
          ),
        ],
      );

      // Verificar producto principal.
      final product = await repository.getProductById(productId);

      expect(product, isNotNull);
      expect(product!.name, 'Alimento Test Nutricional');
      expect(product.price, 24990);
      expect(product.presentation, '3 kg');

      // Verificar imágenes nutricionales.
      final images = await repository.getNutritionImages(productId);

      expect(images.length, 2);
      expect(images[0].imagePath, '/imagenes/nutricion.jpg');
      expect(images[1].imageUrl, 'https://example.com/ingredientes.jpg');

      // Verificar nutrientes escritos.
      final nutrients = await repository.getNutritionValues(productId);

      expect(nutrients.length, 2);
      expect(nutrients[0].nutrientName, 'Proteínas');
      expect(nutrients[0].amount, 26);
      expect(nutrients[1].nutrientName, 'Grasas');
      expect(nutrients[1].amount, 14);

      // Verificar eliminación en cascada.
      await repository.deleteProduct(productId);

      expect(await repository.getNutritionImages(productId), isEmpty);

      expect(await repository.getNutritionValues(productId), isEmpty);
    });

    test('Revierte la operación si un nutriente es inválido', () async {
      await expectLater(
        repository.createProductWithNutrition(
          ProductsCompanion.insert(
            name: 'Producto inválido',
            category: 'Perros',
            description: '',
            price: 10000,
          ),
          nutrients: const [
            NutritionValueInput(
              nutrientName: '',
              amount: 20,
              unit: '%',
              referenceBasis: 'Por 100 g',
            ),
          ],
        ),
        throwsArgumentError,
      );

      // El producto tampoco debe quedar registrado.
      final products = await repository.getAllProducts();

      expect(products, isEmpty);
    });
  });
}
