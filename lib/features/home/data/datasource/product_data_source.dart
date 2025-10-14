

import 'package:fake_store_lyqx/features/home/data/datasource/models/product_dto.dart';
import 'package:fake_store_lyqx/features/home/data/datasource/network/product_api_service.dart';

class ProductDataSource {
  ProductDataSource({required ProductApiService productApiService})
    : _productApiService = productApiService;

  final ProductApiService _productApiService;

  Future<List<ProductDto>> getProducts() async {
    try {
      return await _productApiService.getProducts();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ProductDto> getProduct(int id) async {
    try {
      return await _productApiService.getProduct(id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
