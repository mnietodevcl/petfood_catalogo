import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 420,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Marca
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: const Color(0xFFF0F0EB),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0D000000),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipOval(
                                      child: Image.asset(
                                        'assets/images/petfood_app_icon.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'PetFood Catálogo',
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Título
                      Text(
                        'Todo para su alimentación',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Descripción
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'Consulta y administra productos de alimento para '
                          'animales de manera rápida y sencilla.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                            height: 1.45,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Zona visual
                      AspectRatio(
                        aspectRatio: 1.34,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                'assets/images/petfood_login_hero.png',
                                fit: BoxFit.cover,
                              ),

                              // Degradado suave inferior para dar contraste a la etiqueta
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 75,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withValues(alpha: 0.10),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // Etiqueta inferior
                              Positioned(
                                left: 14,
                                right: 14,
                                bottom: 10,
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 13,
                                      vertical: 7,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.surface.withValues(alpha: 0.92),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.pets_rounded,
                                          size: 15,
                                          color: AppColors.primary,
                                        ),
                                        const SizedBox(width: 6),
                                        Flexible(
                                          child: Text(
                                            'Nutrición clínica y bienestar diario',
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme.bodyMedium?.copyWith(
                                              color: AppColors.textSecondary,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Botón Google
                      SizedBox(
                        height: 54,
                        child: OutlinedButton(
                          onPressed: () {
                            // FASE 4:
                            // aquí se implementará Google Sign-In.
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.surface,
                            foregroundColor: AppColors.textPrimary,
                            side: const BorderSide(
                              color: Color(0xFF7AA7F8),
                              width: 1.4,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                              'assets/images/google_logo.png',
                              width: 21,
                              height: 21,
                              fit: BoxFit.contain,
                            ),
                              const SizedBox(width: 12),
                              Text(
                                'Continuar con Google',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Seguridad
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Icon(
                                Icons.shield_rounded,
                                color: AppColors.primary,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Acceso seguro con tu cuenta de Google.\n'
                                'No compartimos tu información personal.',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontSize: 14,
                                  height: 1.25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Sincronización
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 7),
                              child: Icon(
                                Icons.circle,
                                color: AppColors.primary,
                                size: 6,
                              ),
                            ),
                            const SizedBox(width: 7),
                            Expanded(
                              child: Text(
                                'Catálogo sincronizado en tiempo real',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}