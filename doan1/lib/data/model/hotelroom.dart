import 'package:doan1/data/model/remote/base_response.dart';
import 'package:doan1/data/model/remote/list_model_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hotelroom.g.dart';

@JsonSerializable()
class HotelRoom{
  @JsonKey(name: '_id')
  final String? id;
  final int? number;
  final String? hotel;
  final int? adultCapacity;
  final int? childrenCapacity;
  final double? price;
  final int? checkInHour;
  final int? checkInMinute;
  final int? checkOutHour;
  final int? checkOutMinute;

  HotelRoom(
    this.id,
    this.number,
    this.hotel,
    this.adultCapacity,
    this.childrenCapacity,
    this.price,
    this.checkInHour,
    this.checkInMinute,
    this.checkOutHour,
    this.checkOutMinute
  );

  factory HotelRoom.fromJson(Map<String, dynamic> json) =>
      _$HotelRoomFromJson(json);

  Map<String, dynamic> toJson() => _$HotelRoomToJson(this);
}

extension HotelRoomExtension on BaseResponse{
  HotelRoom? toHotelRoom(){
    if(this.data == null)
      return null;
    return HotelRoom.fromJson(this.data!);
  }
}

extension HotelRoomListExtension on ListModelResponse{
  List<HotelRoom>? toListHotelRoom(){
    if(this.data.length == 0)
      return null;
    List<HotelRoom> rs = [];
    for(Map<String, dynamic> item in this.data){
      rs.add(HotelRoom.fromJson(item));
    }
    print("List hotel: $rs");
    return rs;
  }
}