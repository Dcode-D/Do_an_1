import 'package:bloc/bloc.dart';
import 'package:doan1/data/model/article.dart';
import 'package:meta/meta.dart';

part 'article_item_event.dart';
part 'article_item_state.dart';

class ArticleItemBloc extends Bloc<ArticleItemEvent,ArticleItemState>{
  Article? article;
  ArticleItemBloc() : super(ArticleItemState(getItemSuccess: false)){
    on<GetArticleItemData>((event,emit)async{
      emit(ArticleItemState(getItemSuccess: false));
      article = event.article;
      if(article != null){
        emit(ArticleItemState(getItemSuccess: true));
      }
      else{
        emit(ArticleItemState(getItemSuccess: false));
      }
    });
  }
}