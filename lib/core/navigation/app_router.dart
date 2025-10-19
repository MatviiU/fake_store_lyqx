import 'package:fake_store_lyqx/core/di/get_it.dart';
import 'package:fake_store_lyqx/core/navigation/screen_names.dart';
import 'package:fake_store_lyqx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fake_store_lyqx/features/auth/presentation/screens/login_screen.dart';
import 'package:fake_store_lyqx/features/cart/presentation/screens/cart_screen.dart';
import 'package:fake_store_lyqx/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:fake_store_lyqx/features/home/data/repository/models/product_entity.dart';
import 'package:fake_store_lyqx/features/home/presentation/bloc/home_bloc.dart';
import 'package:fake_store_lyqx/features/home/presentation/screens/home_screen.dart';
import 'package:fake_store_lyqx/features/home/presentation/screens/main_shell.dart';
import 'package:fake_store_lyqx/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:fake_store_lyqx/features/product_details/presentation/screens/product_details_screen.dart';
import 'package:fake_store_lyqx/features/welcome/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter({required AuthBloc authBloc}) : _authBloc = authBloc;

  final AuthBloc _authBloc;

  late final router = GoRouter(
    initialLocation: '/welcome',
    routes: [
      GoRoute(
        path: '/welcome',
        name: ScreenNames.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/login',
        name: ScreenNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: ScreenNames.home,
                builder: (context, state) {
                  return BlocProvider(
                    create: (context) =>
                        getIt<HomeBloc>()..add(HomeDataRequested()),
                    child: const HomeScreen(),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'product-details/:productId',
                    name: ScreenNames.productDetails,
                    builder: (context, state) {
                      final product = state.extra! as ProductEntity;
                      return BlocProvider(
                        create: (context) => getIt<ProductDetailsCubit>()
                          ..getProduct(
                            int.parse(state.pathParameters['productId']!),
                          ),
                        child: ProductDetailsScreen(product: product),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favorites',
                name: ScreenNames.favorites,
                builder: (context, state) => const FavoritesScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/cart',
                name: ScreenNames.cart,
                builder: (context, state) => const CartScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final authState = _authBloc.state;
      final currentLocation = state.uri.toString();

      final isAuthRoute = ['/login', '/welcome'].contains(currentLocation);
      if (authState is AuthSuccess) {
        if (isAuthRoute) {
          return '/home';
        }
      }
      if (authState is Unauthenticated) {
        if (!isAuthRoute) {
          return '/welcome';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(_authBloc.stream),
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    stream.asBroadcastStream().listen((_) => notifyListeners());
  }
}
