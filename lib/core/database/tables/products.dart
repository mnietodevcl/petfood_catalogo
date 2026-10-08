
import 'package:drift/drift.dart';

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get category => text()();

  TextColumn get description => text()();

  RealColumn get price => real()();

  // Imagen principal del alimento
  TextColumn get productImagePath =>
      text().nullable()();

  TextColumn get productImageUrl =>
      text().nullable()();

  // Imagen de la tabla nutricional
  TextColumn get nutritionImagePath =>
      text().nullable()();

  TextColumn get nutritionImageUrl =>
      text().nullable()();

  // Fechas de registro
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
