import 'package:flutter/material.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar producto'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('Pantalla Editar producto: $productId'),
        ),
      ),
    );
  }
}
