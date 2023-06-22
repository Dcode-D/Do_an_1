import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doan1/data/model/article.dart';
import 'package:doan1/data/repositories/article_repo.dart';
import 'package:doan1/data/repositories/hotel_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/favorite.dart';
import '../../../data/model/hotel.dart';
import '../../../data/model/tour.dart';
import '../../../data/repositories/tour_repo.dart';

part 'tour_item_event.dart';
part 'tour_item_state.dart';

class TourItemBloc extends Bloc<TourItemEvent,TourItemState>{
  Tour? tour;
  List<String>? listImage;
  List<Article>? listArticle;
  List<Hotel>? listHotel;
  Favorite? favorite;
  var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
  TourItemBloc() : super(InitialTourItemState()){
  on<GetTourItemEvent>((event,emit) async {
    if(event.tourId == null){
      emit(GetTourItemState(getTourItemSuccess: false));
      return;
    }
    tour = await getTourById(event.tourId!);
    listImage = [];
    listArticle = [];
    listHotel = [];
    if(tour == null){
      emit(GetTourItemState(getTourItemSuccess: false));
      return;
    }
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
  }

  Future<Tour?> getTourById(String id) async {
    var result = await GetIt.instance.get<TourRepository>().getTourById(id);
    return result;
  }

  Future<Article?> getArticleById(String id) async {
    var result = await GetIt.instance.get<ArticleRepository>().getArticleById(id);
    return result;
  }
}