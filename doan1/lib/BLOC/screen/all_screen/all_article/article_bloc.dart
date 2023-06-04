import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/article.dart';
import '../../../../data/repositories/articale_repo.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent,ArticleState>{
  List<Article>? listArticle;
  List<String>? listImage;
  ArticleBloc() : super(ArticleState(getDataSuccess: false)){

    on<GetArticleData>((event, emit) async {
      emit(ArticleState(getDataSuccess: false));
      listArticle = await getArticle(1);

      if(listArticle != null){
        emit(ArticleState(getDataSuccess: true));
      }
      else{
        emit(ArticleState(getDataSuccess: false));
      }
    });
  }
  Future<List<Article>?> getArticle(int page) async {
    var articleRepo = GetIt.instance.get<ArticleRepo>();
    try {
      var listIdArticle = await articleRepo.getListId(page);
      List<Article> tempList = [];
      if(listIdArticle != null){
        for(var id in listIdArticle){
          try{
            var article = await articleRepo.getArticleById(id);
            if(article != null){
              tempList.add(article);
            }
          }
          catch(e){
            print(e);
          }
        }
      }
      return tempList;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}