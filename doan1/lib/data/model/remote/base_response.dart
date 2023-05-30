import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {

  final String? message;
  final String? status;


  final Map<String, dynamic>? data;

  BaseResponse(
      {
        required this.status,
        required this.message,
        required this.data});

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);

}
