import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/article.dart';
import '../../../data/model/tour.dart';
import '../../../data/repositories/article_repo.dart';
import '../../../data/repositories/tour_repo.dart';

part 'manage_news_event.dart';
part 'manage_news_state.dart';

class ManageNewsBloc extends Bloc<ManageNewsEvent,ManageNewsState>{
  List<Article>? lsArticle = [];
  List<Article>? listExtraArticle;
  List<Tour>? lsTour = [];
  List<Tour>? lsExtraTour;

  ManageNewsBloc() : super(ManageNewsInitial()) {
    on<GetNews>((event,emit) async {
      lsArticle!.clear();
      lsTour!.clear();
      lsArticle = await getListArticleByUserId(event.userID,1);
      lsTour = await getListTourByUserId(event.userID,1);
      if(lsArticle != null && lsTour != null){
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

    on<LoadMoreTours>((event,emit) async {
      lsExtraTour = null;
      lsExtraTour = await getListTourByUserId(event.userID,event.page);
      if(lsExtraTour == null){
        emit(LoadMoreTourState(isTourLoaded: false));
        return;
      }
      for (var i = 0; i < lsExtraTour!.length; i++) {
        lsTour!.add(lsExtraTour![i]);
      }
      emit(LoadMoreTourState(isTourLoaded: true));
    });

    on<DeleteTour>((event,emit) async {
      if(lsTour == null){
        emit(DeleteTourState(isDeleted: false));
        return;
      }
      lsTour!.removeAt(event.tourIndex);
      emit(DeleteTourState(isDeleted: true));
    });
  }
  Future<List<Article>?> getListArticleByUserId(String userID,int page) async {
    var articleRepo = GetIt.instance.get<ArticleRepository>();
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

  Future<List<Tour>?> getListTourByUserId(String userId, int page) async {
    var tourRepo = GetIt.instance.get<TourRepository>();
    try{
      var result = await tourRepo.getListTourByUser(page,userId);
      if (result == null){
        return null;
      }
      for (var i in result){
        Tour? tour = i;
        lsTour!.add(tour);
      }
      return lsTour;
    }catch(e){
      print(e);
      return null;
    }
  }
}