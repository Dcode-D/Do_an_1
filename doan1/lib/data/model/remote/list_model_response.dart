import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'list_model_response.g.dart';

@JsonSerializable()
class ListModelResponse{
  final List<Map<String, dynamic>> data;
  ListModelResponse(this.data);
  factory ListModelResponse.fromJson(Map<String, dynamic> json) =>
      _$ListModelResponseFromJson(json);
  Map<String,dynamic> toJson() => _$ListModelResponseToJson(this);
}
