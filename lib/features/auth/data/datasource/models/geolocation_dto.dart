import 'package:json_annotation/json_annotation.dart';

part 'geolocation_dto.g.dart';

@JsonSerializable()
class GeolocationDto {
  const GeolocationDto({this.lat, this.long});

  factory GeolocationDto.fromJson(Map<String, dynamic> json) =>
      _$GeolocationDtoFromJson(json);

  final String? lat;
  final String? long;

  Map<String, dynamic> toJson() => _$GeolocationDtoToJson(this);
}
