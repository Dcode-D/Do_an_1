
import 'dart:io';

import 'package:doan1/data/model/remote/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle.g.dart';

@JsonSerializable()
class Vehicle{
  final String id;
  final String licensePlate;
  final String brand;
  final int seats;
  final int pricePerDay;
  final String color;
  final String description;
  final List<String> images;
  final String owner;

  Vehicle(
    this.id,
    this.licensePlate,
    this.brand,
    this.seats,
    this.pricePerDay,
    this.color,
    this.description,
    this.images,
    this.owner
  );

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}

extension VehicleExtension on BaseResponse{
  List<Vehicle>? toListVehicle(){
    if(this.data == null)
      return null;
    var list = this.data!['data'];
    if(list == null)
      return null;
    List<Vehicle> rs = [];
    for(var item in list){
      rs.add(Vehicle.fromJson(item));
    }
    print(rs);
    return rs;
  }
}