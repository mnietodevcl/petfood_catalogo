import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Pantalla Home'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.push('/product/add'),
                child: const Text('Agregar producto'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => context.push('/product/1'),
                child: const Text('Ver producto de prueba'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => context.push('/profile'),
                child: const Text('Perfil'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
