import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doan1/data/model/article.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'article_item_event.dart';
part 'article_item_state.dart';

class ArticleItemBloc extends Bloc<ArticleItemEvent,ArticleItemState>{
  Article? article;
  List<String>? listImages;
  ArticleItemBloc() : super(ArticleItemState(getItemSuccess: false)){
    listImages = [];
    on<GetArticleItemData>((event,emit)async{
      emit(ArticleItemState(getItemSuccess: false));
      var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
      article = event.article;
      for (var item in article!.images!){
        listImages!.add('$baseUrl/files/' + item['_id']);
      }
      if(article != null ){
        emit(ArticleItemState(getItemSuccess: true));
      }
      else{
        emit(ArticleItemState(getItemSuccess: false));
      }
    });
  }
}