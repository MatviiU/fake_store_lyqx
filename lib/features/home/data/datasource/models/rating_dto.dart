import 'package:json_annotation/json_annotation.dart';

part 'rating_dto.g.dart';

@JsonSerializable()
class RatingDto {
  const RatingDto({required this.rate, required this.count});

  factory RatingDto.fromJson(Map<String, dynamic> json) =>
      _$RatingDtoFromJson(json);

  final double rate;
  final int count;

  Map<String, dynamic> toJson() => _$RatingDtoToJson(this);
}
