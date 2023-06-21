import 'package:json_annotation/json_annotation.dart';

part 'id_response.g.dart';

@JsonSerializable()
class IdResponse {

  final String? message;
  final String? status;
  final String? data;

  IdResponse(
      {
        required this.status,
        required this.message,
        required this.data});

  factory IdResponse.fromJson(Map<String, dynamic> json) =>
      _$IdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IdResponseToJson(this);

}