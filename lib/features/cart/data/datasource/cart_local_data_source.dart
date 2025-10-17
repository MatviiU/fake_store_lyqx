import 'dart:convert';
import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_item_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartLocalDataSource {
  CartLocalDataSource({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  String _generateCartKey(int userId) => 'cart_user_$userId';

  Future<void> saveCart({
    required int userId,
    required List<CartItemEntity> items,
  }) async {
    try {
      final cartJson = items.map((item) => item.toJson()).toList();
      final encodedCart = json.encode(cartJson);
      await _sharedPreferences.setString(_generateCartKey(userId), encodedCart);
    } catch (e) {
      throw Exception('Failed to save cart to local storage');
    }
  }

  Future<List<CartItemEntity>> getCart({required int userId}) async {
    try {
      final encodedCart = _sharedPreferences.getString(
        _generateCartKey(userId),
      );
      if (encodedCart == null) {
        return [];
      }
      final decodedCart = json.decode(encodedCart) as List<dynamic>;
      final cartItems = decodedCart
          .map((item) => CartItemEntity.fromJson(item as Map<String, dynamic>))
          .toList();
      return cartItems;
    } catch (e) {
      throw Exception('Failed to get cart from local storage');
    }
  }
}
