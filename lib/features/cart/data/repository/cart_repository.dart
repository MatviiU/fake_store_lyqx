import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_entity.dart';

abstract interface class CartRepository {
  Future<CartEntity> getCart(int id);

  Future<CartEntity> createCart(CartEntity cart);

  Future<void> deleteCart(int id);
}
