import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Hotel {
  final String id;
  final String name;
  final String address;
  Hotel( this.id, this.name, this.address);
}

//this is just a place holder for the real data