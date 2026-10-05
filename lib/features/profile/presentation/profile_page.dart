import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Pantalla Perfil'),
        ),
      ),
    );
  }
}
