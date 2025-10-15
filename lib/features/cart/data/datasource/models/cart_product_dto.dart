import 'package:json_annotation/json_annotation.dart';

part 'cart_product_dto.g.dart';

@JsonSerializable()
class CartProductDto {
  const CartProductDto({required this.productId, required this.quantity});

  factory CartProductDto.fromJson(Map<String, dynamic> json) =>
      _$CartProductDtoFromJson(json);

  final int productId;
  final int quantity;

  Map<String, dynamic> toJson() => _$CartProductDtoToJson(this);
}
