import 'package:doan1/data/model/remote/base_response.dart';
import 'package:doan1/data/model/remote/list_model_response.dart';
import 'package:doan1/data/model/remote/rating_point_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating.g.dart';

@JsonSerializable()
class Rating{
  @JsonKey(name: '_id')
  final String? id;
  final String? user;
  final String? service;
  final double? rating;
  final String? comment;
  final String? type;

  Rating({
    required this.id,
    required this.user,
    required this.service,
    required this.rating,
    required this.comment,
    required this.type
  });

  factory Rating.fromJson(Map<String, dynamic> json) =>
      _$RatingFromJson(json);
  Map<String, dynamic> toJson() => _$RatingToJson(this);
}

extension RatingListExtension on ListModelResponse{
  List<Rating>? toListRating(){
    if(this.data.length == 0)
      return null;
    List<Rating> rs = [];
    for(Map<String, dynamic> item in this.data){
      rs.add(Rating.fromJson(item));
    }
    print("List hotel: $rs");
    return rs;
  }
}

extension RatingDetailExtension on BaseResponse{
  Rating? toRating(){
    if(this.data == null)
      return null;
    return Rating.fromJson(this.data!);
  }
}

extension RatingPointExtension on RatingPointResponse{
  double? toRatingPoint(){
    if(this.data == null)
      return null;
    return this.data;
  }
}