import 'package:fake_store_lyqx/features/auth/data/datasource/models/geolocation_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class AddressDto {
  const AddressDto({this.city, this.street, this.number, this.zipcode, this.geolocation});
  factory AddressDto.fromJson(Map<String, dynamic> json) => _$AddressDtoFromJson(json);

  final String? city;
  final String? street;
  final int? number;
  final String? zipcode;
  final GeolocationDto? geolocation;

  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);
}