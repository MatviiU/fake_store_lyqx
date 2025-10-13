import 'package:fake_store_lyqx/features/home/data/models/product.dart';

abstract interface class ProductRepository {
  Future<List<Product>> getProducts();

  Future<Product> getProduct(int id);
}
