import 'package:fake_store_lyqx/features/home/data/datasource/models/rating_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto {
  const ProductDto({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.rating,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  final int id;
  final String title;
  final String image;
  final double price;
  final RatingDto rating;

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);
}
