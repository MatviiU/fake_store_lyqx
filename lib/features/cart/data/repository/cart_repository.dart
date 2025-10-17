import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_item_entity.dart';

abstract interface class CartRepository {
  Future<List<CartItemEntity>> getCart({required int userId});

  Future<void> saveCart({
    required int userId,
    required List<CartItemEntity> items,
  });
}
