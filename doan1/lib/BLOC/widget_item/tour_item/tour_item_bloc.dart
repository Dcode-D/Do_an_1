import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doan1/data/model/article.dart';
import 'package:doan1/data/repositories/article_repo.dart';
import 'package:doan1/data/repositories/hotel_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/favorite.dart';
import '../../../data/model/hotel.dart';
import '../../../data/model/rating.dart';
import '../../../data/model/tour.dart';
import '../../../data/repositories/favorite_repo.dart';
import '../../../data/repositories/rating_repo.dart';
import '../../../data/repositories/tour_repo.dart';

part 'tour_item_event.dart';
part 'tour_item_state.dart';

class TourItemBloc extends Bloc<TourItemEvent,TourItemState>{
  Tour? tour;
  List<String>? listImage;
  List<Article>? listArticle;
  List<Hotel>? listHotel;
  Favorite? favorite;
  List<Rating>? listRating;
  double? ratingByCustomer;
  var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
  TourItemBloc() : super(InitialTourItemState()){
  on<GetTourItemEvent>((event,emit) async {
    if(event.tourId == null){
      emit(GetTourItemState(getTourItemSuccess: false));
      return;
    }
    tour = await getTourById(event.tourId!);
    if(tour == null){
      emit(GetTourItemState(getTourItemSuccess: false));
      return;
    }
    listImage = [];
    listImage!.clear();
    listArticle = [];
    listHotel = [];
    for (var item in tour!.articles!){
      Article? article = await getArticleById(item);
      if(article == null){
        emit(GetTourItemState(getTourItemSuccess: false));
        return;
      }
      listArticle!.add(article);
      for(var i in article.images!){
        listImage!.add('$baseUrl/files/' + i['_id']);
      }
    }
    if(tour!.hotel == null){

    }
    else if (tour!.hotel!.isNotEmpty){
      for (var item in tour!.hotel!){
        Hotel? hotel = await GetIt.instance.get<HotelRepository>().getHotelById(item);
        if(hotel == null){
          emit(GetTourItemState(getTourItemSuccess: false));
          return;
        }
        listHotel!.add(hotel);
      }
    }
    if(tour != null && listArticle != null){
      emit(GetTourItemState(getTourItemSuccess: true));
    }
    else{
      emit(GetTourItemState(getTourItemSuccess: false));
    }
  });

  on<LikeTourEvent>((event,emit) async {
    if(tour == null){
      emit(TourItemLoveState(loveTourSuccess: false));
      return;
    }
    var result = await createFavoriteTour(tour!.id!,event.userId!);
    if(result == true){
      emit(TourItemLoveState(loveTourSuccess: true));
    }
    else{
      emit(TourItemLoveState(loveTourSuccess: false));
    }
  });
  on<DislikeTourEvent>((event,emit) async {
    if(favorite == null){
      emit(TourItemLoveState(loveTourSuccess: false));
      return;
    }
    var result = await deleteFavoriteTour(favorite!.id!);
    if(result == true){
      emit(TourItemLoveState(loveTourSuccess: false));
    }
    else{
      emit(TourItemLoveState(loveTourSuccess: true));
    }
  });
  on<GetTourIsFavorite>((event,emit)async{
    if(tour == null){
      emit(TourItemGetFavoriteState(getTourFavoriteSuccess: false));
      return;
    }
    var result = await isTourFavorite(tour!.id!);
    if (result == null){
      emit(TourItemGetFavoriteState(getTourFavoriteSuccess: false));
    }
    else{
      if(result == ""){
        emit(TourItemGetFavoriteState(getTourFavoriteSuccess: false));
        return;
      }
      favorite = await getFavoriteById(result);
      if(favorite == null){
        emit(TourItemGetFavoriteState(getTourFavoriteSuccess: false));
      }
      else{
        emit(TourItemGetFavoriteState(getTourFavoriteSuccess: true));
      }
    }
  });

}

  Future<Tour?> getTourById(String id) async {
    var result = await GetIt.instance.get<TourRepository>().getTourById(id);
    return result;
  }

  Future<Article?> getArticleById(String id) async {
    var result = await GetIt.instance.get<ArticleRepository>().getArticleById(id);
    return result;
  }

  Future<Favorite?> getFavoriteById(String id) async {
    var favoriteRepo = GetIt.instance.get<FavoriteRepository>();
    try{
      var result = await favoriteRepo.getFavoriteById(id);
      return result;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<bool> createFavoriteTour(String tourId,String userId) async {
    var favoriteRepo = GetIt.instance.get<FavoriteRepository>();
    try{
      var result = await favoriteRepo.createFavorite("tour",userId,tourId);
      return result;
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> deleteFavoriteTour(String favoriteTourId) async{
    var favoriteRepo = GetIt.instance.get<FavoriteRepository>();
    try{
      var result = await favoriteRepo.deleteFavorite(favoriteTourId);
      return result;
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<String?> isTourFavorite(String tourId) async {
    var favoriteRepo = GetIt.instance.get<FavoriteRepository>();
    try{
      var result = await favoriteRepo.getIsFavoriteByService("tour",tourId);
      return result;
    }catch(e){
      print(e);
      return null;
    }
  }

}