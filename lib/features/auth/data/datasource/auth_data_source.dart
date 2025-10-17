import 'package:fake_store_lyqx/features/auth/data/datasource/models/login_response.dart';
import 'package:fake_store_lyqx/features/auth/data/datasource/models/user_dto.dart';
import 'package:fake_store_lyqx/features/auth/data/datasource/network/auth_api_service.dart';

class AuthDataSource {
  AuthDataSource({required AuthApiService authApiService})
    : _authApiService = authApiService;

  final AuthApiService _authApiService;

  Future<LoginResponse> login(String username, String password) async {
    try {
      return await _authApiService.login({
        'username': username,
        'password': password,
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserDto> getUser(int id) async {
    try {
      return await _authApiService.getUser(id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
