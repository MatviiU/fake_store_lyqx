import 'package:fake_store_lyqx/features/auth/data/datasource/models/user_dto.dart';

class UserEntity {
  const UserEntity({
    required this.id,
    required this.username,
    required this.password,
  });

  factory UserEntity.fromDto(UserDto dto) {
    return UserEntity(
      id: dto.id ?? 0,
      username: dto.username ?? '',
      password: dto.password ?? '',
    );
  }

  final int id;
  final String username;
  final String password;
}
