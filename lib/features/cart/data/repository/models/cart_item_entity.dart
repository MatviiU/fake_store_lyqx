import 'package:fake_store_lyqx/features/home/data/models/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item_entity.g.dart';

@JsonSerializable()
class CartItemEntity {
  const CartItemEntity({required this.product, required this.quantity});

  factory CartItemEntity.fromJson(Map<String, dynamic> json) =>
      _$CartItemEntityFromJson(json);

  final ProductEntity product;
  final int quantity;

  Map<String, dynamic> toJson() => _$CartItemEntityToJson(this);

  CartItemEntity copyWith({ProductEntity? product, int? quantity}) {
    return CartItemEntity(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
