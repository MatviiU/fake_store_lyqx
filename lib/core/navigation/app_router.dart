import 'package:fake_store_lyqx/core/di/get_it.dart';
import 'package:fake_store_lyqx/core/navigation/screen_names.dart';
import 'package:fake_store_lyqx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fake_store_lyqx/features/auth/presentation/screens/login_screen.dart';
import 'package:fake_store_lyqx/features/home/presentation/bloc/home_bloc.dart';
import 'package:fake_store_lyqx/features/home/presentation/screens/home_screen.dart';
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
      routes: [
        GoRoute(
          path: '/login',
          name: ScreenNames.login,
          builder: (context, state) => BlocProvider(
            create: (context) => getIt<AuthBloc>(),
            child: const LoginScreen(),
          ),
          routes: [
            GoRoute(
              path: '/home/:userId',
              name: ScreenNames.home,
              builder: (context, state) => BlocProvider(
                create: (context) => getIt<HomeBloc>()
                  ..add(
                    HomeDataRequested(
                      userId: int.parse(state.pathParameters['userId']!),
                    ),
                  ),
                child: const HomeScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
