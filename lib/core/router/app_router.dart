import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_page.dart';
import '../../features/products/presentation/add_product_page.dart';
import '../../features/products/presentation/edit_product_page.dart';
import '../../features/products/presentation/home_page.dart';
import '../../features/products/presentation/product_detail_page.dart';
import '../../features/profile/presentation/profile_page.dart';

/// Escucha los cambios de sesión de Firebase y le avisa a GoRouter
/// que debe volver a evaluar sus redirecciones.
class AuthRefreshNotifier extends ChangeNotifier {
  AuthRefreshNotifier() {
    _subscription = FirebaseAuth.instance.authStateChanges().listen(
      (_) {
        notifyListeners();
      },
    );
  }

  late final StreamSubscription<User?> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final AuthRefreshNotifier authRefreshNotifier = AuthRefreshNotifier();

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',

  refreshListenable: authRefreshNotifier,

  redirect: (context, state) {
    final user = FirebaseAuth.instance.currentUser;

    final isAuthenticated = user != null;
    final isOnLoginPage = state.matchedLocation == '/login';

    // Sin sesión:
    // cualquier ruta protegida vuelve al Login.
    if (!isAuthenticated) {
      return isOnLoginPage ? null : '/login';
    }

    // Con sesión:
    // no tiene sentido permanecer o volver al Login.
    if (isAuthenticated && isOnLoginPage) {
      return '/home';
    }

    // El resto de las rutas continúa normalmente.
    return null;
  },

  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),

    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),

    GoRoute(
      path: '/product/add',
      builder: (context, state) => const AddProductPage(),
    ),

    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final productId = state.pathParameters['id'] ?? '';

        return ProductDetailPage(
          productId: productId,
        );
      },
      routes: [
        GoRoute(
          path: 'edit',
          builder: (context, state) {
            final productId = state.pathParameters['id'] ?? '';

            return EditProductPage(
              productId: productId,
            );
          },
        ),
      ],
    ),

    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
    ),
  ],
);