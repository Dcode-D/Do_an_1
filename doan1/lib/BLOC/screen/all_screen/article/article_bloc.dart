import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/article.dart';
import '../../../../data/repositories/article_repo.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent,ArticleState>{
  List<Article>? listArticle =[];
  ArticleBloc() : super(ArticleState(getDataSuccess: false)){
    var _currentPage = 0;
    var _searchQuery = "";

    on<GetArticleData>((event, emit) async {
      emit(ArticleState(getDataSuccess: false));
      _currentPage++;
      if(_searchQuery.isEmpty) {
        var tempList = await getArticle(_currentPage, null, null, null);
        if (tempList != null) {
          listArticle!.addAll(tempList);
          emit(ArticleState(getDataSuccess: true));
        }
        else {
          emit(ArticleState(getDataSuccess: false));
        }
      }
      else{
        var tempList = await getArticle(_currentPage, null, null, _searchQuery);
        var tempList2 = await getArticle(_currentPage, null, _searchQuery, null);
        var tempList3 = await getArticle(_currentPage, _searchQuery, null, null);
        if (tempList != null) {
          listArticle!.addAll(tempList);
          listArticle!.addAll(tempList2!);
          listArticle!.addAll(tempList3!);
          emit(ArticleState(getDataSuccess: true));
        }
        else {
          emit(ArticleState(getDataSuccess: false));
        }
      }
    });
    on<GetArticleByQuery>((event, emit) async {
      emit(ArticleState(getDataSuccess: false));
      _searchQuery = event.query;
      _currentPage = 0;
      listArticle = [];
      add(GetArticleData());
    });
  }
  Future<List<Article>?> getArticle(int page, String? city, String? province, String? name) async {
    var articleRepo = GetIt.instance.get<ArticleRepository>();
    try {
      var listIdArticle = await articleRepo.getListId(page,city, province, name);
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