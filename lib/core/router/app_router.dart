import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_page.dart';
import '../../features/products/presentation/add_product_page.dart';
import '../../features/products/presentation/edit_product_page.dart';
import '../../features/products/presentation/home_page.dart';
import '../../features/products/presentation/product_detail_page.dart';
import '../../features/profile/presentation/profile_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
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
        return ProductDetailPage(productId: productId);
      },
      routes: [
        GoRoute(
          path: 'edit',
          builder: (context, state) {
            final productId = state.pathParameters['id'] ?? '';
            return EditProductPage(productId: productId);
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
