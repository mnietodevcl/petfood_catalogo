import 'package:drift/drift.dart';

import 'products.dart';

class ProductNutritionValues extends Table {
  // Identificador único del registro nutricional.
  IntColumn get id => integer().autoIncrement()();

  // Producto al que pertenece el nutriente.
  IntColumn get productId =>
      integer().references(Products, #id, onDelete: KeyAction.cascade)();

  // Nombre del nutriente: Proteínas, Grasas, Fibra, etc.
  TextColumn get nutrientName => text()();

  // Valor numérico: 26, 14.5, 0.8, etc.
  RealColumn get amount => real()();

  // Unidad: %, g, mg, kcal, etc.
  TextColumn get unit => text()();

  // Referencia: por 100 g, por 1 kg, por porción,
  // análisis garantizado, etc.
  TextColumn get referenceBasis => text().nullable()();

  // Indicación opcional: mínimo, máximo, etc.
  TextColumn get qualifier => text().nullable()();

  // Orden en que aparece dentro de la tabla.
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}
