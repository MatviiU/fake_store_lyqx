import 'package:dio/dio.dart';
import 'package:fake_store_lyqx/features/auth/data/repository/auth_repository.dart';
import 'package:fake_store_lyqx/features/home/data/datasource/product_data_source.dart';
import 'package:fake_store_lyqx/features/home/data/repository/models/product_entity.dart';
import 'package:fake_store_lyqx/features/home/data/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({
    required ProductDataSource productDataSource,
    required AuthRepository authRepository,
  }) : _productDataSource = productDataSource,
       _authRepository = authRepository;

  final ProductDataSource _productDataSource;
  final AuthRepository _authRepository;

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
      final token = await _authRepository.getToken() as String?;
      if (token == null) {
        throw Exception('User is not authenticated');
      }
      final products = await _productDataSource.getProducts();
      final entities = products.map(ProductEntity.fromDto).toList();
      return entities;
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<ProductEntity>> getProductsByIds(List<int> ids) async {
    if (ids.isEmpty) {
      return [];
    }
    try {
      final products = await _productDataSource.getProducts();
      final favoritesIds = ids.toSet();
      final favoritesProducts = products
          .where((product) => favoritesIds.contains(product.id))
          .toList();
      final entities = favoritesProducts.map(ProductEntity.fromDto).toList();
      return entities;
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
