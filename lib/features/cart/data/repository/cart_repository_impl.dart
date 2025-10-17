import 'package:fake_store_lyqx/features/cart/data/datasource/cart_local_data_source.dart';
import 'package:fake_store_lyqx/features/cart/data/repository/cart_repository.dart';
import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_item_entity.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl({required CartLocalDataSource cartLocalDataSource})
    : _cartLocalDataSource = cartLocalDataSource;

  final CartLocalDataSource _cartLocalDataSource;

  @override
  Future<List<CartItemEntity>> getCart({required int userId}) async {
    try {
      final cartItems = await _cartLocalDataSource.getCart(userId: userId);
      return cartItems;
    } catch (e) {
      throw Exception('Failed to get cart');
    }
  }

  @override
  Future<void> saveCart({
    required int userId,
    required List<CartItemEntity> items,
  }) async {
    try {
      await _cartLocalDataSource.saveCart(userId: userId, items: items);
    } catch (e) {
      throw Exception('Failed to save cart');
    }
  }
}
