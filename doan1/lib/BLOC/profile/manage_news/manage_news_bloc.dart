import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/article.dart';
import '../../../data/repositories/article_repo.dart';

part 'manage_news_event.dart';
part 'manage_news_state.dart';

class ManageNewsBloc extends Bloc<ManageNewsEvent,ManageNewsState>{
  List<Article>? lsArticle;
  ManageNewsBloc() : super(ManageNewsInitial(isNewsLoaded: false)) {
    lsArticle = [];
    on<GetNews>((event,emit) async {
      lsArticle?.clear();
      lsArticle = await getListArticleByUserId(event.userID,1);
      if(lsArticle != null){
        emit(ManageNewsInitial(isNewsLoaded: true));
      }
      else{
        emit(ManageNewsInitial(isNewsLoaded: false));
      }
    });
  }
  Future<List<Article>?> getListArticleByUserId(String userID,int page) async {
    var articleRepo = GetIt.instance.get<ArticleRepo>();
    try{
      var result = await articleRepo.getListIdArticleFromUser(page,userID);
      if (result == null){
        return null;
      }
      for (var i in result){
        Article? article = await articleRepo.getArticleById(i);
        if(article != null){
          lsArticle!.add(article);
        }
        else{
          return null;
        }
      }
      return lsArticle;
    }catch(e){
      print(e);
      return null;
    }
  }
}