import 'package:json_annotation/json_annotation.dart';

part 'name_dto.g.dart';

@JsonSerializable()
class NameDto {
  const NameDto({this.firstname, this.lastname});

  factory NameDto.fromJson(Map<String, dynamic> json) =>
      _$NameDtoFromJson(json);

  final String? firstname;
  final String? lastname;

  Map<String, dynamic> toJson() => _$NameDtoToJson(this);
}
