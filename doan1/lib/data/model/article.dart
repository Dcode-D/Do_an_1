import 'package:doan1/data/model/remote/base_response.dart';
import 'package:doan1/data/model/remote/list_model_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article{
  @JsonKey(name: "_id")
  String? id;
  String? title;
  String? description;
  List<Map<String,dynamic>>? images;
  String? province;
  String? city;
  String? referenceName;
  DateTime? publishedDate;
  String? address;

  Article({
    this.id,
     this.title,
     this.description,
     this.images,
     this.province,
     this.city,
     this.referenceName,
     this.publishedDate,
     this.address
  });

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
extension ArticleExtension on BaseResponse{
  Article? toArticle(){
    if(this.data == null)
      return null;
    return Article.fromJson(this.data!);
  }
}

extension ArticleListIdExtension on ListModelResponse{
  List<String>? toListIdArticle(){
    if(this.data.length == 0)
      return null;
    List<String> rs = [];
    for(Map<String, dynamic> item in this.data){
      rs.add(item['_id']);
    }
    print("List article_item_bloc.dart id: $rs");
    return rs;
  }
}