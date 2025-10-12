import 'package:fake_store_lyqx/features/auth/data/models/login_response.dart';

abstract interface class AuthRepository{
  Future<LoginResponse> login(String username, String password);
}
