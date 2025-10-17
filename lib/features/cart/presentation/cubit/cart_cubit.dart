import 'package:fake_store_lyqx/features/cart/data/repository/cart_repository.dart';
import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_entity.dart';
import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_product_entity.dart';
import 'package:fake_store_lyqx/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required CartRepository cartRepository})
    : _cartRepository = cartRepository,
      super(CartInitial());

  final CartRepository _cartRepository;

  Future<void> getCartDetails(int userId) async {
    emit(CartLoading());
    try {
      final cart = await _cartRepository.getCart(userId);
      final cartItems = await _cartRepository.getCartDetails(userId);
      emit(CartLoaded(items: cartItems, userId: cart.userId, cartId: cart.id));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> createCart(CartEntity cart) async {
    emit(CartLoading());
    try {
      final createdCart = await _cartRepository.createCart(cart);
      await getCartDetails(createdCart.id);
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> updateItemQuantity({
    required int cartId,
    required int userId,
    required int productId,
    required int newQuantity,
  }) async {
    final cartItems = await _cartRepository.getCartDetails(userId);
    final itemIndex = cartItems.indexWhere(
      (item) => item.product.id == productId,
    );

    if (itemIndex != -1) {
      if (newQuantity > 0) {
        cartItems[itemIndex] = cartItems[itemIndex].copyWith(
          quantity: newQuantity,
        );
      } else {
        cartItems.removeAt(itemIndex);
      }
    } else {
      return;
    }
    final updatedProducts = cartItems.map((item) {
      return CartProductEntity(
        productId: item.product.id,
        quantity: item.quantity,
      );
    }).toList();

    final cartToUpdate = CartEntity(
      id: userId,
      userId: userId,
      products: updatedProducts,
    );

    try {
      await _cartRepository.updateCart(userId, cartToUpdate);
      emit(
        CartLoaded(
          items: cartItems,
          userId: cartToUpdate.userId,
          cartId: cartToUpdate.id,
        ),
      );
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
