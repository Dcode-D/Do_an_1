import 'package:doan1/data/model/remote/base_response.dart';
import 'package:doan1/data/model/remote/list_model_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tour.g.dart';

@JsonSerializable()
class Tour{
  @JsonKey(name: '_id')
  final String? id;
  final String? user;
  final String? name;
  final String? description;
  final List<String>? articles;
  final List<String>? hotel;
  final double? price;
  final double? rating;
  final int? duration;
  final int? maxGroupSize;

  Tour({
    required this.id,
    required this.user,
    required this.name,
    required this.description,
    required this.articles,
    required this.hotel,
    required this.price,
    required this.rating,
    required this.duration,
    required this.maxGroupSize
  });

  factory Tour.fromJson(Map<String, dynamic> json) =>
      _$TourFromJson(json);
  Map<String, dynamic> toJson() => _$TourToJson(this);
}

extension TourListExtension on ListModelResponse{
  List<Tour>? toListTour(){
    if(this.data.length == 0)
      return null;
    List<Tour> rs = [];
    for(Map<String, dynamic> item in this.data){
      rs.add(Tour.fromJson(item));
    }
    print("List hotel: $rs");
    return rs;
  }
}

extension TourDetailExtension on BaseResponse{
  Tour? toTour(){
    if(this.data == null)
      return null;
    return Tour.fromJson(this.data!);
  }
}