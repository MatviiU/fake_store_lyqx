import 'package:dio/dio.dart';
import 'package:fake_store_lyqx/features/home/data/models/product.dart';
import 'package:fake_store_lyqx/features/home/data/home_repository.dart';
import 'package:fake_store_lyqx/features/home/datasource/product_api_service.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required ProductApiService apiService})
    : _apiService = apiService;

  final ProductApiService _apiService;

  @override
  Future<Product> getProduct(int id) {
    try {
      return _apiService.getProduct(id);
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Product>> getProducts() {
    try {
      return _apiService.getProducts();
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
