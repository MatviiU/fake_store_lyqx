import 'package:fake_store_lyqx/core/di/get_it.dart';
import 'package:fake_store_lyqx/core/navigation/screen_names.dart';
import 'package:fake_store_lyqx/features/auth/data/models/user.dart';
import 'package:fake_store_lyqx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fake_store_lyqx/features/auth/presentation/screens/login_screen.dart';
import 'package:fake_store_lyqx/features/home/data/models/product_entity.dart';
import 'package:fake_store_lyqx/features/home/presentation/bloc/home_bloc.dart';
import 'package:fake_store_lyqx/features/home/presentation/screens/home_screen.dart';
import 'package:fake_store_lyqx/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:fake_store_lyqx/features/product_details/presentation/screens/product_details_screen.dart';
import 'package:fake_store_lyqx/features/welcome/presentation/screens/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
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
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthBloc>(),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: '/home',
      name: ScreenNames.home,
      builder: (context, state) {
        final user = state.extra! as User;
        return BlocProvider(
          create: (context) =>
              getIt<HomeBloc>()..add(HomeDataRequested(user: user)),
          child: const HomeScreen(),
        );
      },
      routes: [
        GoRoute(
          path: '/product-details/:productId',
          name: ScreenNames.productDetails,
          builder: (context, state) {
            final product = state.extra! as ProductEntity;
            return BlocProvider(
              create: (context) =>
                  getIt<ProductDetailsCubit>()
                    ..getProduct(int.parse(state.pathParameters['productId']!)),
              child: ProductDetailsScreen(product: product),
            );
          },
        ),
      ],
    ),
  ],
);
