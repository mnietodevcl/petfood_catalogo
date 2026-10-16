import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:petfood_catalogo/core/database/app_database.dart';
import 'package:petfood_catalogo/features/products/data/product_repository.dart';

void main() {
  group('Edición de productos con nutrición', () {
    late AppDatabase database;
    late ProductRepository repository;

    setUp(() {
      database = AppDatabase(NativeDatabase.memory());
      repository = ProductRepository(database);
    });

    tearDown(() async {
      await database.close();
    });

    // Crear un producto inicial para cada prueba.
    Future<int> createOriginalProduct() {
      return repository.createProductWithNutrition(
        ProductsCompanion.insert(
          name: 'Pedigree Adulto',
          category: 'Perros',
          description: 'Alimento original',
          price: 33900,
          presentation: const Value('15 kg'),
        ),
        images: const [
          NutritionImageInput.fromUrl(
            'https://example.com/nutricion-original.jpg',
          ),
        ],
        nutrients: const [
          NutritionValueInput(
            nutrientName: 'Proteínas',
            amount: 26,
            unit: '%',
            referenceBasis: 'Por 100 g',
          ),
        ],
      );
    }

    // ========================================================
    // PRUEBA 1: ACTUALIZAR CORRECTAMENTE
    // ========================================================

    test('Actualiza producto, nutrientes e imágenes', () async {
      final productId = await createOriginalProduct();

      final updated = await repository.updateProductWithNutrition(
        productId,
        const ProductsCompanion(
          name: Value('Pedigree Adulto Premium'),
          price: Value(39990),
          presentation: Value('18 kg'),
        ),
        images: const [
          NutritionImageInput.fromGallery('/imagenes/nueva-tabla.jpg'),
        ],
        nutrients: const [
          NutritionValueInput(
            nutrientName: 'Proteínas',
            amount: 28,
            unit: '%',
            referenceBasis: 'Por 100 g',
          ),
          NutritionValueInput(
            nutrientName: 'Grasas',
            amount: 14,
            unit: '%',
            referenceBasis: 'Por 100 g',
          ),
        ],
      );

      expect(updated, isTrue);

      // Comprobar los datos principales.
      final product = await repository.getProductById(productId);

      expect(product, isNotNull);
      expect(product!.name, 'Pedigree Adulto Premium');
      expect(product.price, 39990);
      expect(product.presentation, '18 kg');
      expect(product.category, 'Perros');

      // Comprobar imágenes nutricionales.
      final images = await repository.getNutritionImages(productId);

      expect(images.length, 1);
      expect(images.first.imagePath, '/imagenes/nueva-tabla.jpg');
      expect(images.first.imageUrl, isNull);

      // Comprobar nutrientes actualizados.
      final nutrients = await repository.getNutritionValues(productId);

      expect(nutrients.length, 2);
      expect(nutrients[0].nutrientName, 'Proteínas');
      expect(nutrients[0].amount, 28);
      expect(nutrients[1].nutrientName, 'Grasas');
      expect(nutrients[1].amount, 14);
    });

    // ========================================================
    // PRUEBA 2: REVERTIR CAMBIOS ANTE ERROR
    // ========================================================

    test('Revierte la edición si falla SQLite', () async {
      final productId = await createOriginalProduct();

      // Crear un trigger temporal que provoque un error
      // al intentar insertar un nutriente específico.
      await database.customStatement('''
          CREATE TRIGGER fail_nutrient_insert
          BEFORE INSERT ON product_nutrition_values
          WHEN NEW.nutrient_name = 'Error provocado'
          BEGIN
            SELECT RAISE(ABORT, 'fallo de prueba');
          END;
        ''');

      // Intentar modificar producto, imagen y nutrientes.
      await expectLater(
        repository.updateProductWithNutrition(
          productId,
          const ProductsCompanion(
            name: Value('Producto modificado'),
            price: Value(99999),
          ),
          images: const [
            NutritionImageInput.fromUrl('https://example.com/nueva-imagen.jpg'),
          ],
          nutrients: const [
            NutritionValueInput(
              nutrientName: 'Error provocado',
              amount: 30,
              unit: '%',
              referenceBasis: 'Por 100 g',
            ),
          ],
        ),
        throwsA(isA<Exception>()),
      );

      // Verificar que el producto conserva sus datos.
      final product = await repository.getProductById(productId);

      expect(product, isNotNull);
      expect(product!.name, 'Pedigree Adulto');
      expect(product.price, 33900);
      expect(product.presentation, '15 kg');

      // Verificar que conserva la fotografía anterior.
      final images = await repository.getNutritionImages(productId);

      expect(images.length, 1);
      expect(
        images.first.imageUrl,
        'https://example.com/nutricion-original.jpg',
      );

      // Verificar que conserva el nutriente anterior.
      final nutrients = await repository.getNutritionValues(productId);

      expect(nutrients.length, 1);
      expect(nutrients.first.nutrientName, 'Proteínas');
      expect(nutrients.first.amount, 26);
    });
  });
}
