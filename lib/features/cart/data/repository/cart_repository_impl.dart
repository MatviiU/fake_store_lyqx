import 'package:fake_store_lyqx/features/cart/data/datasource/cart_data_source.dart';
import 'package:fake_store_lyqx/features/cart/data/repository/cart_repository.dart';
import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_entity.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl({required CartDataSource cartDataSource})
    : _cartDataSource = cartDataSource;

  final CartDataSource _cartDataSource;

  @override
  Future<CartEntity> createCart(CartEntity cart) async {
    try {
      final dto = cart.toDto();
      final createdCart = await _cartDataSource.createCart(dto);
      final entity = CartEntity.fromDto(createdCart);
      return entity;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteCart(int id) async {
    try {
      await _cartDataSource.deleteCart(id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<CartEntity> getCart(int id) async {
    try {
      final cart = await _cartDataSource.getCart(id);
      final entity = CartEntity.fromDto(cart);
      return entity;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
