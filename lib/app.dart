import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';

class PetFoodApp extends StatelessWidget {
  const PetFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetFood Catálogo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const BasePage(),
    );
  }
}

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PetFood Catálogo'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text(
            'PetFood Catálogo',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}