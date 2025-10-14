import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fake_store_lyqx/features/auth/data/auth_repository.dart';
import 'package:fake_store_lyqx/features/auth/data/models/user.dart';
import 'package:fake_store_lyqx/features/home/data/models/product_entity.dart';
import 'package:fake_store_lyqx/features/home/data/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required ProductRepository productRepository,
    required AuthRepository authRepository,
  }) : _productRepository = productRepository,
       _authRepository = authRepository,
       super(HomeInitial()) {
    on<HomeDataRequested>(_onUserRequested);
  }

  final ProductRepository _productRepository;
  final AuthRepository _authRepository;

  Future<void> _onUserRequested(
    HomeDataRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final result = await Future.wait([
        _authRepository.getUser(event.userId),
        _productRepository.getProducts(),
      ]);

      final user = result[0] as User;
      final products = result[1] as List<ProductEntity>;

      emit(HomeLoaded(user: user, products: products));
    } on DioException catch (e) {
      emit(HomeError(message: e.message!));
    } catch (e) {
      emit(const HomeError(message: 'Something went wrong'));
    }
  }
}
