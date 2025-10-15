import 'package:fake_store_lyqx/features/cart/data/repository/cart_repository.dart';
import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_entity.dart';
import 'package:fake_store_lyqx/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required CartRepository cartRepository})
    : _cartRepository = cartRepository,
      super(CartInitial());

  final CartRepository _cartRepository;

  Future<void> getCart(int id) async {
    emit(CartLoading());
    try {
      final cart = await _cartRepository.getCart(id);
      emit(CartLoaded(cart: cart));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> createCart(CartEntity cart) async {
    emit(CartLoading());
    try {
      final createdCart = await _cartRepository.createCart(cart);
      emit(CartLoaded(cart: createdCart));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> deleteCart(int id) async {
    emit(CartLoading());
    try {
      await _cartRepository.deleteCart(id);
      emit(CartDeleted());
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }
}
