import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/article.dart';
import '../../../data/repositories/article_repo.dart';

part 'manage_news_event.dart';
part 'manage_news_state.dart';

class ManageNewsBloc extends Bloc<ManageNewsEvent,ManageNewsState>{
  List<Article>? lsArticle;

  List<Article>? listExtraArticle;
  ManageNewsBloc() : super(ManageNewsInitial()) {
    on<GetNews>((event,emit) async {
      lsArticle = [];
      lsArticle = await getListArticleByUserId(event.userID,1);
      if(lsArticle != null){
        emit(GetNewsInitialState(isNewsLoaded: true));
      }
      else{
        emit(GetNewsInitialState(isNewsLoaded: false));
      }
    });
    on<LoadMoreNews>((event,emit) async{
      listExtraArticle = null;
      listExtraArticle = await getListArticleByUserId(event.userID,event.page);
      if(listExtraArticle == null){
        emit(LoadMoreNewsState(isNewsLoaded: false));
        return;
      }
      for (var i = 0; i < listExtraArticle!.length; i++) {
        lsArticle!.add(listExtraArticle![i]);
      }
      emit(LoadMoreNewsState(isNewsLoaded: true));
    });
    on<DeleteNews>((event,emit) async{
      if(lsArticle == null){
        emit(DeleteNewsState(isDeleted: false));
        return;
      }
      lsArticle!.removeAt(event.articleIndex);
      emit(DeleteNewsState(isDeleted: true));
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