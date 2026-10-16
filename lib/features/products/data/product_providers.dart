import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import 'product_repository.dart';

// Instancia compartida de nuestra base de datos.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();

  ref.onDispose(() {
    database.close();
  });

  return database;
});

// Repositorio de productos.
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);

  return ProductRepository(database);
});

// Productos actualizados automáticamente desde SQLite.
final productsProvider = StreamProvider<List<Product>>((ref) {
  final repository = ref.watch(productRepositoryProvider);

  return repository.watchAllProducts();
});
