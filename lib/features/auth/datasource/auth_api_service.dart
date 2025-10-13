import 'package:dio/dio.dart';
import 'package:fake_store_lyqx/features/auth/data/models/login_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: 'https://fakestoreapi.com')
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST('/auth/login')
  Future<LoginResponse> login(@Body() Map<String, dynamic> body);
}
