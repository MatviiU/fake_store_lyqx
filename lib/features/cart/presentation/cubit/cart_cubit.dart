import 'package:fake_store_lyqx/features/cart/data/repository/cart_repository.dart';
import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_item_entity.dart';
import 'package:fake_store_lyqx/features/cart/presentation/cubit/cart_state.dart';
import 'package:fake_store_lyqx/features/home/data/models/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required CartRepository cartRepository})
    : _cartRepository = cartRepository,
      super(CartInitial());

  final CartRepository _cartRepository;

  int? _currentUserId;

  Future<void> getCart({required int userId}) async {
    if (state is CartLoaded && _currentUserId == userId) {
      return;
    }

    emit(CartLoading());
    try {
      _currentUserId = userId;
      final cartItems = await _cartRepository.getCart(userId: userId);
      emit(CartLoaded(items: cartItems));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> saveCart({
    required int userId,
    required List<CartItemEntity> items,
  }) async {
    try {
      await _cartRepository.saveCart(userId: userId, items: items);
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  void addItem(ProductEntity product) {
    if (state is! CartLoaded || _currentUserId == null) return;
    final currentState = state as CartLoaded;
    final updatedItems = [...currentState.items];
    final itemIndex = updatedItems.indexWhere(
      (item) => item.product.id == product.id,
    );
    if (itemIndex != -1) {
      final existingItem = updatedItems[itemIndex];
      updatedItems[itemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      );
    } else {
      updatedItems.add(CartItemEntity(product: product, quantity: 1));
    }
    _updateAndSaveCart(updatedItems);
  }

  void updateQuantity({required int productId, required int newQuantity}) {
    if (state is! CartLoaded || _currentUserId == null) return;
    final currentState = state as CartLoaded;
    final updatedItems = [...currentState.items];
    final itemIndex = updatedItems.indexWhere(
      (item) => item.product.id == productId,
    );

    if (itemIndex != -1) {
      if (newQuantity > 0) {
        final existingItem = updatedItems[itemIndex];
        updatedItems[itemIndex] = existingItem.copyWith(quantity: newQuantity);
      } else {
        updatedItems.removeAt(itemIndex);
      }
    }
    _updateAndSaveCart(updatedItems);
  }

  void clearCart() {
    if (_currentUserId == null) return;
    _updateAndSaveCart([]);
  }

  Future<void> _updateAndSaveCart(List<CartItemEntity> items) async {
    emit(CartLoaded(items: items));
    try {
      await _cartRepository.saveCart(userId: _currentUserId!, items: items);
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }
}
