import 'package:dio/dio.dart';
import 'package:fake_store_lyqx/features/cart/data/datasource/models/cart_dto.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'cart_api_service.g.dart';

@RestApi(baseUrl: 'https://fakestoreapi.com')
abstract class CartApiService {
  factory CartApiService(Dio dio, {String baseUrl}) = _CartApiService;

  @GET('/carts/{id}')
  Future<CartDto> getCart(@Path('id') int id);

  @POST('/carts')
  Future<CartDto> createCart(@Body() CartDto cart);

  @DELETE('/carts/{id}')
  Future<void> deleteCart(@Path('id') int id);
}
