
import 'package:doan1/data/model/remote/base_response.dart';
import 'package:doan1/data/model/remote/id_response.dart';
import 'package:doan1/data/model/remote/list_model_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite.g.dart';

@JsonSerializable()
class Favorite{
  @JsonKey(name: "_id")
  String? id;
  String? user;
  String? element;
  String? type;

  Favorite({
    this.id,
    this.user,
    this.element,
    this.type,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => _$FavoriteFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteToJson(this);
}

extension FavoriteListExtension on ListModelResponse{
  List<String>? toListIdFavorite(){
    if(this.data.length == 0)
      return null;
    List<String> rs = [];
    for(Map<String, dynamic> item in this.data){
      rs.add(item['_id']);
    }
    print("List favorite: $rs");
    return rs;
  }
}

extension FavoriteTransformExtension on BaseResponse{
  Favorite? toFavorite(){
    if(this.data == null)
      return null;
    return Favorite.fromJson(this.data!);
  }
}

extension FavoriteIdExtension on IdResponse{
  String? toFavoriteId(){
    if(this.data == null)
      return null;
    return this.data;
  }
}