import 'package:dio/dio.dart';
import 'package:fake_store_lyqx/features/auth/data/auth_repository.dart';
import 'package:fake_store_lyqx/features/auth/data/repository/auth_repository_impl.dart';
import 'package:fake_store_lyqx/features/auth/datasource/auth_api_service.dart';
import 'package:fake_store_lyqx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt
    ..registerLazySingleton<Dio>(Dio.new)
    ..registerLazySingleton<AuthApiService>(() => AuthApiService(getIt<Dio>()))
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(apiService: getIt<AuthApiService>()),
    )
    ..registerFactory<AuthBloc>(
      () => AuthBloc(authRepository: getIt<AuthRepository>()),
    );
}
