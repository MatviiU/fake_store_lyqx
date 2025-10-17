import 'package:fake_store_lyqx/features/auth/data/datasource/models/address_dto.dart';
import 'package:fake_store_lyqx/features/auth/data/datasource/models/name_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  const UserDto({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return _$UserDtoFromJson(json);
  }

  final int? id;
  final String? username;
  final String? email;
  final String? password;
  final NameDto? name;
  final AddressDto? address;
  final String? phone;

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
