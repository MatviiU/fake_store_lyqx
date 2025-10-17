import 'package:fake_store_lyqx/features/cart/data/datasource/models/cart_product_dto.dart';

class CartProductEntity {
  CartProductEntity({required this.productId, required this.quantity});

  final int productId;
  final int quantity;

  CartProductDto toDto() {
    return CartProductDto(productId: productId, quantity: quantity);
  }
}
