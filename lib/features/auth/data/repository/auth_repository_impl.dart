import 'package:dio/dio.dart';
import 'package:fake_store_lyqx/features/auth/data/auth_repository.dart';
import 'package:fake_store_lyqx/features/auth/data/datasource/auth_data_source.dart';
import 'package:fake_store_lyqx/features/auth/data/datasource/models/login_response.dart';
import 'package:fake_store_lyqx/features/auth/data/repository/models/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthDataSource authDataSource,
    required SharedPreferences sharedPreferences,
  }) : _authDataSource = authDataSource,
       _sharedPreferences = sharedPreferences;

  final AuthDataSource _authDataSource;
  final SharedPreferences _sharedPreferences;

  static const _tokenKey = 'auth_token';

  @override
  Future<LoginResponse> login(String username, String password) async {
    try {
      return await _authDataSource.login(username, password);
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserEntity> getUser(int id) async {
    try {
      final userDto = await _authDataSource.getUser(id);
      final entity = UserEntity.fromDto(userDto);
      return entity;
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteToken() async {
    await _sharedPreferences.remove(_tokenKey);
  }

  @override
  Future<String> getToken() async {
    return _sharedPreferences.getString(_tokenKey) ?? '';
  }

  @override
  Future<void> saveToken(String token) async {
    await _sharedPreferences.setString(_tokenKey, token);
  }
}
