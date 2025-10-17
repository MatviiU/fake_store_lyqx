import 'package:fake_store_lyqx/core/di/get_it.dart';
import 'package:fake_store_lyqx/core/navigation/app_router.dart';
import 'package:fake_store_lyqx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fake_store_lyqx/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<CartCubit>()),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter(authBloc: context.read<AuthBloc>());

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.read<CartCubit>().getCart(userId: state.user.id);
        } else if (state is Unauthenticated) {
          context.read<CartCubit>().clearCart();
        }
      },
      child: MaterialApp.router(
        title: 'Fake Store',
        routerConfig: appRouter.router,
      ),
    );
  }
}
