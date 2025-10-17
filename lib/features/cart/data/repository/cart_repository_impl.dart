import 'package:fake_store_lyqx/features/cart/data/datasource/cart_data_source.dart';
import 'package:fake_store_lyqx/features/cart/data/repository/cart_repository.dart';
import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_entity.dart';
import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_item_entity.dart';
import 'package:fake_store_lyqx/features/home/data/datasource/product_data_source.dart';
import 'package:fake_store_lyqx/features/home/data/models/product_entity.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl({
    required CartDataSource cartDataSource,
    required ProductDataSource productDataSource,
  }) : _cartDataSource = cartDataSource,
       _productDataSource = productDataSource;

  final CartDataSource _cartDataSource;
  final ProductDataSource _productDataSource;

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

  @override
  Future<CartEntity> updateCart(int cartId, CartEntity cart) async {
    try {
      final dto = cart.toDto();
      final updatedCartDto = await _cartDataSource.updateCart(cartId, dto);
      final entity = CartEntity.fromDto(updatedCartDto);
      return entity;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<CartItemEntity>> getCartDetails(int userId) async {
    try {
      final cart = await _cartDataSource.getCart(userId);
      final entity = CartEntity.fromDto(cart);
      if (entity.products.isEmpty) {
        return [];
      }
      final products = entity.products.map((e) {
        return _productDataSource.getProduct(e.productId);
      }).toList();
      final productDtos = await Future.wait(products);
      final cartItems = entity.products.map((productInCart) {
        final product = productDtos.firstWhere(
          (dto) => dto.id == productInCart.productId,
        );
        return CartItemEntity(
          product: ProductEntity.fromDto(product),
          quantity: productInCart.quantity,
        );
      }).toList();
      return cartItems;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
