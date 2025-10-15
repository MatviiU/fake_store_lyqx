import 'package:fake_store_lyqx/features/cart/data/datasource/models/cart_product_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_dto.g.dart';

@JsonSerializable()
class CartDto {
  const CartDto({
    required this.id,
    required this.userId,
    required this.products,
  });

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);

  final int id;
  final int userId;
  final List<CartProductDto> products;

  Map<String, dynamic> toJson() => _$CartDtoToJson(this);
}
