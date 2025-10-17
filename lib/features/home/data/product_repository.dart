import 'package:fake_store_lyqx/features/home/data/models/product_entity.dart';

abstract interface class ProductRepository {
  Future<List<ProductEntity>> getProducts();

  Future<ProductEntity> getProduct(int id);

  Future<List<ProductEntity>> getProductsByIds(List<int> ids);
}
