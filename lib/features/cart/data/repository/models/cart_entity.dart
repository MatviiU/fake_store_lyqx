import 'package:fake_store_lyqx/features/cart/data/datasource/models/cart_dto.dart';
import 'package:fake_store_lyqx/features/cart/data/datasource/models/cart_product_dto.dart';

class CartEntity {
  const CartEntity({
    required this.id,
    required this.userId,
    required this.products,
  });

  factory CartEntity.fromDto(CartDto dto) {
    return CartEntity(id: dto.id, userId: dto.userId, products: dto.products);
  }

  final int id;
  final int userId;
  final List<CartProductDto> products;

  CartDto toDto() {
    return CartDto(id: id, userId: userId, products: products);
  }
}
