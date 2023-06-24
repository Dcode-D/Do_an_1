import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'rating_point_response.g.dart';

@JsonSerializable()
class RatingPointResponse {

  final String? message;
  final String? status;

  final double? data;

  RatingPointResponse(
      {
        required this.status,
        required this.message,
        required this.data});

  factory RatingPointResponse.fromJson(Map<String, dynamic> json) =>
      _$RatingPointResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RatingPointResponseToJson(this);

}
