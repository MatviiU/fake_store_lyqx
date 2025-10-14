import 'package:dio/dio.dart';
import 'package:fake_store_lyqx/features/home/data/datasource/product_data_source.dart';
import 'package:fake_store_lyqx/features/home/data/models/product_entity.dart';
import 'package:fake_store_lyqx/features/home/data/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required ProductDataSource productDataSource})
    : _productDataSource = productDataSource;

  final ProductDataSource _productDataSource;

  @override
  Future<ProductEntity> getProduct(int id) async {
    try {
      final product = await _productDataSource.getProduct(id);
      final entity = ProductEntity.fromDto(product);
      return entity;
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    try {
      final products = await _productDataSource.getProducts();
      final entities = products.map(ProductEntity.fromDto).toList();
      return entities;
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
