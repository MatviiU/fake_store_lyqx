import 'package:fake_store_lyqx/features/cart/data/datasource/models/cart_dto.dart';
import 'package:fake_store_lyqx/features/cart/data/datasource/network/cart_api_service.dart';

class CartDataSource {
  CartDataSource({required CartApiService cartApiService})
    : _cartApiService = cartApiService;

  final CartApiService _cartApiService;

  Future<CartDto> getCart(int id) {
    try {
      return _cartApiService.getCart(id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<CartDto> createCart(CartDto cart) {
    try {
      return _cartApiService.createCart(cart);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<CartDto> updateCart(int id, CartDto cart) {
    try {
      return _cartApiService.updateCart(id, cart);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteCart(int id) {
    try {
      return _cartApiService.deleteCart(id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
