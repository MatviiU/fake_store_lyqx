import 'package:dio/dio.dart';
import 'package:fake_store_lyqx/features/auth/data/auth_repository.dart';
import 'package:fake_store_lyqx/features/auth/data/repository/auth_repository_impl.dart';
import 'package:fake_store_lyqx/features/auth/datasource/auth_api_service.dart';
import 'package:fake_store_lyqx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fake_store_lyqx/features/home/data/datasource/network/product_api_service.dart';
import 'package:fake_store_lyqx/features/home/data/datasource/product_data_source.dart';
import 'package:fake_store_lyqx/features/home/data/product_repository.dart';
import 'package:fake_store_lyqx/features/home/data/repository/product_repository_impl.dart';
import 'package:fake_store_lyqx/features/home/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt
    ..registerLazySingleton<Dio>(Dio.new)
    ..registerLazySingleton<AuthApiService>(() => AuthApiService(getIt<Dio>()))
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(apiService: getIt<AuthApiService>()),
    )
    ..registerLazySingleton<ProductApiService>(
      () => ProductApiService(getIt<Dio>()),
    )
    ..registerLazySingleton<ProductDataSource>(
      () => ProductDataSource(productApiService: getIt<ProductApiService>()),
    )
    ..registerLazySingleton<ProductRepository>(
      () =>
          ProductRepositoryImpl(productDataSource: getIt<ProductDataSource>()),
    )
    ..registerFactory<AuthBloc>(
      () => AuthBloc(authRepository: getIt<AuthRepository>()),
    )
    ..registerFactory<HomeBloc>(
      () => HomeBloc(
        productRepository: getIt<ProductRepository>(),
        authRepository: getIt<AuthRepository>(),
      ),
    );
}
