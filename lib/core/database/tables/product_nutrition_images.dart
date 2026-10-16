import 'package:drift/drift.dart';

import 'products.dart';

class ProductNutritionImages extends Table {
  // Identificador único de cada imagen
  IntColumn get id => integer().autoIncrement()();

  // Producto al que pertenece la imagen
  IntColumn get productId =>
      integer().references(Products, #id, onDelete: KeyAction.cascade)();

  // Ruta cuando la imagen proviene de la galería
  TextColumn get imagePath => text().nullable()();

  // Dirección cuando la imagen proviene de internet
  TextColumn get imageUrl => text().nullable()();

  // Orden en que se muestran las imágenes
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}
