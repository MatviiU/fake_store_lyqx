import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_entity.dart';
import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_item_entity.dart';

abstract interface class CartRepository {
  Future<CartEntity> getCart(int id);

  Future<CartEntity> createCart(CartEntity cart);

  Future<CartEntity> updateCart(int cartId, CartEntity cart);

  Future<void> deleteCart(int id);

  Future<List<CartItemEntity>> getCartDetails(int userId);
}
