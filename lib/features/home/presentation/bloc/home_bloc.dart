import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fake_store_lyqx/features/auth/data/models/user.dart';
import 'package:fake_store_lyqx/features/home/data/models/product_entity.dart';
import 'package:fake_store_lyqx/features/home/data/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required ProductRepository productRepository})
    : _productRepository = productRepository,
      super(HomeInitial()) {
    on<HomeDataRequested>(_onUserRequested);
  }

  final ProductRepository _productRepository;

  Future<void> _onUserRequested(
    HomeDataRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final products = await _productRepository.getProducts();
      emit(HomeLoaded(user: event.user, products: products));
    } on DioException catch (e) {
      emit(HomeError(message: e.message!));
    } catch (e) {
      emit(const HomeError(message: 'Something went wrong'));
    }
  }
}
