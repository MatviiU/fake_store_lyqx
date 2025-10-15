import 'package:dio/dio.dart';
import 'package:fake_store_lyqx/features/home/data/datasource/models/product_dto.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'product_api_service.g.dart';


@RestApi(baseUrl: 'https://fakestoreapi.com')
abstract class ProductApiService{
  factory ProductApiService(Dio dio, {String baseUrl}) = _ProductApiService;

  @GET('/products')
  Future<List<ProductDto>> getProducts();

  @GET('/products/{id}')
  Future<ProductDto> getProduct(@Path('id') int id);
}
