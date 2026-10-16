import 'package:flutter/material.dart';

import 'product_form_page.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final id = int.tryParse(productId);

    if (id == null) {
      return const Scaffold(
        body: Center(child: Text('Identificador de producto inválido')),
      );
    }

    return ProductFormPage(productId: id);
  }
}
