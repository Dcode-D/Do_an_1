import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/article.dart';
import '../../../data/model/hotel.dart';
import '../../../data/model/tour.dart';
import '../../../data/repositories/article_repo.dart';
import '../../../data/repositories/hotel_repo.dart';
import '../../../data/repositories/tour_repo.dart';

part 'edit_tour_event.dart';
part 'edit_tour_state.dart';

class EditTourBloc extends Bloc<EditTourEvent,EditTourState>{
  List<Article> listSelectedTourPlan = [];
  List<Hotel> listSelectedHotel = [];

  Tour? tour;
  List<String>? images;
  List<Article>? listArticle;
  List<Hotel>? listHotel;
  int? index;
  var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
  EditTourBloc() : super(EditTourInitial()){
    on<EditTourInitialEvent>((event,emit)async{
      if(event.tourId == null){
        emit(EditTourDataInitial(false));
        return;
      }
      tour = await getTourById(event.tourId!);
      if(tour == null){
        emit(EditTourDataInitial(false));
        return;
      }
      images = [];
      images!.clear();
      listArticle = [];
      listHotel = [];
      for (var item in tour!.articles!){
        Article? article = await getArticleById(item);
        if(article == null){
          emit(EditTourDataInitial(false));
          return;
        }
        listArticle!.add(article);
        for(var i in article.images!){
          images!.add('$baseUrl/files/' + i['_id']);
        }
      }
      if(tour!.hotel == null){

      }
      else if (tour!.hotel!.isNotEmpty){
        for (var item in tour!.hotel!){
          Hotel? hotel = await GetIt.instance.get<HotelRepository>().getHotelById(item);
          if(hotel == null){
            emit(EditTourDataInitial(false));
            return;
          }
          listHotel!.add(hotel);
        }
      }
      if(tour != null && listArticle != null){
        emit(EditTourDataInitial(true));
      }
      else{
        emit(EditTourDataInitial(false));
      }
    });

    on<DeleteTourEvent>((event,emit) async {
      if(tour == null){
        emit(DeleteTourState(false));
        return;
      }
      var result = await GetIt.instance.get<TourRepository>().deleteTour(tour!.id!);
      if(result == false){
        emit(DeleteTourState(false));
        return;
      }
      emit(DeleteTourState(true));
    });

    on<SetEditTourPlan>((event,emit) {
      for(var i = 0; i < event.tourPlan.length; i++){
        listSelectedTourPlan.add(event.tourPlan[i]);
      }
      listSelectedTourPlan = listSelectedTourPlan.toSet().toList();
      emit(EditPlanSetState(isPlanSet: true));
    });

    on<RemoveEditTourPlan>((event,emit) {
      listSelectedTourPlan.removeWhere((element) => element.id == event.article.id);
      emit(EditPlanSetState(isPlanSet: true));
    });

    on<SetEditHotelPlan>((event,emit) {
      for(var i = 0; i < event.tourHotel.length; i++){
        listSelectedHotel.add(event.tourHotel[i]);
      }
      listSelectedHotel = listSelectedHotel.toSet().toList();
      emit(EditHotelSetState(isHotelSet: true));
    });

    on<RemoveEditHotelPlan>((event,emit) {
      listSelectedHotel.removeWhere((element) => element.id == event.hotel.id);
      emit(EditHotelSetState(isHotelSet: true));
    });
  }

  Future<Article?> getArticleById(String id) async {
    var result = await GetIt.instance.get<ArticleRepository>().getArticleById(id);
    return result;
  }

  Future<Tour?> getTourById(String id) async {
    var result = await GetIt.instance.get<TourRepository>().getTourById(id);
    return result;
  }
}