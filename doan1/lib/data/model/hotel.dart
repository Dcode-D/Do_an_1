import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Hotel {
  final String id;
  final String name;
  final String address;
  final String owner;
  final String description;
  final String province;
  final String city;
  Hotel(
    this.id,
    this.name,
    this.address,
    this.owner,
    this.description,
    this.province,
    this.city
  );
}

//this is just a place holder for the real data