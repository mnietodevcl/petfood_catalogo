import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Producto'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Pantalla Detalle de producto: $productId'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.push('/product/$productId/edit'),
                child: const Text('Editar producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
