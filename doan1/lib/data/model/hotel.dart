import 'package:doan1/data/model/remote/list_model_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hotel.g.dart';

@JsonSerializable()
class Hotel {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? address;
  final String? owner;
  final String? description;
  final List<String>? images;
  final String? province;
  final String? city;
  Hotel(
    this.id,
    this.name,
    this.address,
    this.owner,
    this.description,
    this.images,
    this.province,
    this.city
  );

  factory Hotel.fromJson(Map<String, dynamic> json) =>
      _$HotelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelToJson(this);
}

extension HotelExtension on ListModelResponse{
  List<Hotel>? toListHotel(){
    if(this.data.length == 0)
      return null;
    List<Hotel> rs = [];
    for(Map<String, dynamic> item in this.data){
      rs.add(Hotel.fromJson(item));
    }
    print("List hotel: $rs");
    return rs;
  }
}