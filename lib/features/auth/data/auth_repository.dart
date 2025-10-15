import 'package:fake_store_lyqx/features/auth/data/models/login_response.dart';
import 'package:fake_store_lyqx/features/auth/data/models/user.dart';

abstract interface class AuthRepository{
  Future<LoginResponse> login(String username, String password);
  Future<User> getUser(int id);
}
