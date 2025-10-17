import 'package:dio/dio.dart';
import 'package:fake_store_lyqx/features/auth/data/auth_repository.dart';
import 'package:fake_store_lyqx/features/auth/data/datasource/auth_data_source.dart';
import 'package:fake_store_lyqx/features/auth/data/datasource/network/auth_api_service.dart';
import 'package:fake_store_lyqx/features/auth/data/repository/auth_repository_impl.dart';
import 'package:fake_store_lyqx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fake_store_lyqx/features/cart/data/datasource/cart_local_data_source.dart';
import 'package:fake_store_lyqx/features/cart/data/repository/cart_repository.dart';
import 'package:fake_store_lyqx/features/cart/data/repository/cart_repository_impl.dart';
import 'package:fake_store_lyqx/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fake_store_lyqx/features/favorites/data/favorites_storage_service.dart';
import 'package:fake_store_lyqx/features/favorites/data/favorites_storage_service_impl.dart';
import 'package:fake_store_lyqx/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:fake_store_lyqx/features/home/data/datasource/network/product_api_service.dart';
import 'package:fake_store_lyqx/features/home/data/datasource/product_data_source.dart';
import 'package:fake_store_lyqx/features/home/data/product_repository.dart';
import 'package:fake_store_lyqx/features/home/data/repository/product_repository_impl.dart';
import 'package:fake_store_lyqx/features/home/presentation/bloc/home_bloc.dart';
import 'package:fake_store_lyqx/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt
    ..registerLazySingleton<Dio>(Dio.new)
    ..registerLazySingleton<AuthApiService>(() => AuthApiService(getIt<Dio>()))
    ..registerLazySingleton<ProductApiService>(
      () => ProductApiService(getIt<Dio>()),
    )
    ..registerLazySingleton<AuthDataSource>(
      () => AuthDataSource(authApiService: getIt<AuthApiService>()),
    )
    ..registerLazySingleton<ProductDataSource>(
      () => ProductDataSource(productApiService: getIt<ProductApiService>()),
    )
    ..registerLazySingleton<CartLocalDataSource>(
      () => CartLocalDataSource(sharedPreferences: getIt<SharedPreferences>()),
    )
    ..registerLazySingleton<FavoriteStorageService>(
      () => FavoriteStorageServiceImpl(
        sharedPreferences: getIt<SharedPreferences>(),
      ),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        sharedPreferences: getIt<SharedPreferences>(),
        authDataSource: getIt<AuthDataSource>(),
      ),
    )
    ..registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(
        productDataSource: getIt<ProductDataSource>(),
        authRepository: getIt<AuthRepository>(),
      ),
    )
    ..registerLazySingleton<CartRepository>(
      () =>
          CartRepositoryImpl(cartLocalDataSource: getIt<CartLocalDataSource>()),
    )
    ..registerFactory<AuthBloc>(
      () => AuthBloc(authRepository: getIt<AuthRepository>()),
    )
    ..registerFactory<HomeBloc>(
      () => HomeBloc(productRepository: getIt<ProductRepository>()),
    )
    ..registerFactory<ProductDetailsCubit>(
      () => ProductDetailsCubit(productRepository: getIt<ProductRepository>()),
    )
    ..registerFactory<CartCubit>(
      () => CartCubit(cartRepository: getIt<CartRepository>()),
    )
    ..registerFactory<FavoritesCubit>(
      () => FavoritesCubit(
        favoriteStorageService: getIt<FavoriteStorageService>(),
        productRepository: getIt<ProductRepository>(),
      ),
    );
}
