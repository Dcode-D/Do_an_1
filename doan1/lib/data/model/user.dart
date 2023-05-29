import 'dart:io';

import 'package:doan1/data/model/remote/avatar_file_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:doan1/data/model/remote/base_response.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  final String id;
  final String username;
  final String password;
  final int gender;
  final String email;
  final String firstname;
  final String lastname;
  final String phonenumber;
  final String address;
  User(
    this.id,
      this.username,
      this.password,
      this.gender,
      this.email,
      this.firstname,
      this.lastname,
      this.phonenumber,
      this.address
      );

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

extension UserExtension on BaseResponse {
  User? toUser() {
    if(this.data == null)
      return null;
    return User.fromJson(this.data!);
  }
}

extension UserFileExtension on AvatarResponse{
  List<String>? toListString(){
    var list = this.data!;
    if(list == null)
      return null;
    List<String> rs = List<String>.from(list);
    print(rs);
    return rs;
  }
}
