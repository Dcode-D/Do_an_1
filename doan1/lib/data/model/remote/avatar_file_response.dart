import 'package:json_annotation/json_annotation.dart';

part 'avatar_file_response.g.dart';

@JsonSerializable()
class AvatarResponse{

  final List<String>? data;

  AvatarResponse(
      {
        required this.data});

  factory AvatarResponse.fromJson(Map<String, dynamic> json) =>
      _$AvatarResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarResponseToJson(this);
}