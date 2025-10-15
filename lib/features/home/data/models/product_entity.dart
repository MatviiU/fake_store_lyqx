
import 'package:fake_store_lyqx/features/home/data/datasource/models/product_dto.dart';

class ProductEntity {
  const ProductEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.count,
    required this.rate,
  });

  factory ProductEntity.fromDto(ProductDto dto){
    return ProductEntity(
      id: dto.id,
      title: dto.title,
      image: dto.image,
      price: dto.price,
      count: dto.rating.count,
      rate: dto.rating.rate,
    );
  }

  final int id;
  final String title;
  final String image;
  final double price;
  final int count;
  final double rate;

}
