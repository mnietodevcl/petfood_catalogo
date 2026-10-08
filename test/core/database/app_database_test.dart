import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:petfood_catalogo/core/database/app_database.dart';

void main() {
  group('CRUD en memoria', () {
    late AppDatabase database;

    // Crear una base de datos temporal antes de cada prueba.
    setUp(() {
      database = AppDatabase(NativeDatabase.memory());
    });

    // Cerrar la base de datos después de cada prueba.
    tearDown(() async {
      await database.close();
    });

    test('CRUD completo de productos', () async {
      // 1. Comprobar que la base de datos esté vacía.
      final productosIniciales = await database.getAllProducts();
      expect(productosIniciales, isEmpty);

      // 2. Crear un producto.
      final id = await database.createProduct(
        ProductsCompanion.insert(
          name: 'Royal Canin Adult',
          category: 'Perros',
          description: 'Alimento para perros adultos',
          price: 45990.0,
          productImageUrl: const Value('https://example.com/producto.jpg'),
          nutritionImagePath: const Value('tabla_nutricional.jpg'),
        ),
      );

      expect(id, greaterThan(0));

      // 3. Consultar el producto por su ID.
      final producto = await database.getProductById(id);

      expect(producto, isNotNull);
      expect(producto!.name, 'Royal Canin Adult');
      expect(producto.category, 'Perros');
      expect(producto.price, 45990.0);

      // Comprobar las referencias de imágenes.
      expect(producto.productImageUrl, 'https://example.com/producto.jpg');

      expect(producto.nutritionImagePath, 'tabla_nutricional.jpg');

      // Guardar la fecha original de creación.
      final fechaCreacion = producto.createdAt;

      // 4. Comprobar el listado.
      final productos = await database.getAllProducts();

      expect(productos.length, 1);

      // 5. Actualizar el precio.
      final actualizado = await database.updateProduct(
        id,
        const ProductsCompanion(price: Value(49990.0)),
      );

      expect(actualizado, isTrue);

      // Comprobar los cambios.
      final productoActualizado = await database.getProductById(id);

      expect(productoActualizado, isNotNull);
      expect(productoActualizado!.price, 49990.0);
      expect(productoActualizado.createdAt, fechaCreacion);

      // 6. Eliminar el producto.
      final eliminado = await database.deleteProduct(id);

      expect(eliminado, isTrue);

      // 7. Comprobar que fue eliminado.
      final productoEliminado = await database.getProductById(id);

      expect(productoEliminado, isNull);
      expect(await database.getAllProducts(), isEmpty);
    });
  });
  test('Los productos persisten en disco', () async {
    final directory = await Directory.systemTemp.createTemp('petfood_test_');

    final file = File(
      '${directory.path}${Platform.pathSeparator}products.sqlite',
    );

    AppDatabase? diskDatabase;

    try {
      // 1. Abrir SQLite en disco.
      diskDatabase = AppDatabase(NativeDatabase(file));

      // 2. Crear un producto.
      final id = await diskDatabase.createProduct(
        ProductsCompanion.insert(
          name: 'Pro Plan Adult',
          category: 'Perros',
          description: 'Alimento para perros adultos',
          price: 39990.0,
        ),
      );

      // 3. Cerrar la conexión.
      await diskDatabase.close();
      diskDatabase = null;

      // 4. Reabrir el archivo SQLite.
      diskDatabase = AppDatabase(NativeDatabase(file));

      // 5. Comprobar que el producto sigue guardado.
      final producto = await diskDatabase.getProductById(id);

      expect(producto, isNotNull);
      expect(producto!.name, 'Pro Plan Adult');
      expect(producto.price, 39990.0);
    } finally {
      await diskDatabase?.close();
      await directory.delete(recursive: true);
    }
  });
}
