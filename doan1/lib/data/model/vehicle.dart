
import 'dart:io';

import 'package:doan1/data/model/remote/base_response.dart';
import 'package:doan1/data/model/remote/list_model_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle.g.dart';

@JsonSerializable()
class Vehicle{
  @JsonKey(name: '_id')
  final String? id;
  final String? licensePlate;
  final String? brand;
  final int? seats;
  final int? pricePerDay;
  final String? color;
  final String? description;
  final String? address;
  final String? province;
  final String? city;
  final List<String>? images;
  final String? owner;


  Vehicle(
    @JsonKey(name: '_id')
    this.id,
    this.licensePlate,
    this.brand,
    this.seats,
    this.pricePerDay,
    this.color,
    this.description,
    this.address,
    this.province,
    this.city,
    this.images,
    this.owner
  );

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}

extension VehicleExtension on ListModelResponse{
  List<Vehicle>? toListVehicle(){
    if(this.data.length == 0)
      return null;
    List<Vehicle> rs = [];
    for(Map<String, dynamic> item in this.data){
      rs.add(Vehicle.fromJson(item));
    }
    print("List vehicle: $rs");
    return rs;
  }
}

extension VehicleDetailExtension on BaseResponse{
  Vehicle? toVehicle(){
    if(this.data == null)
      return null;
    return Vehicle.fromJson(this.data!);
  }
}

extension VehiclePageExtension on BaseResponse{
  int? toInt(){
    if(this.data == null)
      return null;
    return this.data as int;
  }
}