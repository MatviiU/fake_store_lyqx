import 'package:fake_store_lyqx/features/cart/data/datasource/models/cart_dto.dart';
import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_product_entity.dart';

class CartEntity {
  const CartEntity({
    required this.id,
    required this.userId,
    required this.products,
  });

  factory CartEntity.fromDto(CartDto dto) {
    return CartEntity(
      id: dto.id,
      userId: dto.userId,
      products: dto.products
          .map(
            (e) =>
                CartProductEntity(productId: e.productId, quantity: e.quantity),
          )
          .toList(),
    );
  }

  final int id;
  final int userId;
  final List<CartProductEntity> products;

  CartDto toDto() {
    return CartDto(
      id: id,
      userId: userId,
      products: products.map((e) => e.toDto()).toList(),
    );
  }
}
