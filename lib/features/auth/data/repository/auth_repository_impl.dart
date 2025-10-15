import 'package:dio/dio.dart';
import 'package:fake_store_lyqx/features/auth/data/auth_repository.dart';
import 'package:fake_store_lyqx/features/auth/data/models/login_response.dart';
import 'package:fake_store_lyqx/features/auth/data/models/user.dart';
import 'package:fake_store_lyqx/features/auth/datasource/auth_api_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthApiService apiService})
    : _apiService = apiService;

  final AuthApiService _apiService;

  @override
  Future<LoginResponse> login(String username, String password) async {
    try {
      return await _apiService.login({
        'username': username,
        'password': password,
      });
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<User> getUser(int id) async {
    try {
      return await _apiService.getUser(id);
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
