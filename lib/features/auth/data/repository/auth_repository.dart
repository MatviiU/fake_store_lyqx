import 'package:fake_store_lyqx/features/auth/data/datasource/models/login_response.dart';
import 'package:fake_store_lyqx/features/auth/data/repository/models/user_entity.dart';

abstract interface class AuthRepository {
  Future<LoginResponse> login(String username, String password);

  Future<UserEntity> getUser(int id);

  Future<void> saveToken(String token);

  Future<String> getToken();

  Future<void> deleteToken();
}
