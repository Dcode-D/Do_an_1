import 'package:bloc/bloc.dart';
import 'package:doan1/data/model/favorite.dart';
import 'package:doan1/data/repositories/favorite_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/hotel.dart';
import '../../../data/model/tour.dart';
import '../../../data/model/vehicle.dart';
import '../../../data/repositories/hotel_repo.dart';
import '../../../data/repositories/tour_repo.dart';
import '../../../data/repositories/vehicle_repo.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  List<Hotel>? listHotel;
  List<Vehicle>? listCar;
  List<Tour>? listTour;
  List<Favorite>? listHotelFavorite;
  List<Favorite>? listCarFavorite;
  List<Favorite>? listTourFavorite;
  FavoriteBloc() : super(FavoriteInitial()){
    on<GetListHotelFavoriteEvent>((event,emit) async {
      listHotel = [];
      listHotelFavorite = [];
      if(event.userId == null){
        emit(FavoriteLoaded(false));
        return;
      }
      var tempLs = await getListIdFavoriteByUserId("hotel", event.userId!);
      if(tempLs == null){
        emit(FavoriteLoaded(false));
        return;
      }
      for (var item in tempLs){
        var favoriteHotel = await getFavoriteById(item);
        if(favoriteHotel != null){
          listHotelFavorite!.add(favoriteHotel);
        }
      }
      for (var item in listHotelFavorite!){
        var hotel = await getHotelById(item.element!);
        if(hotel != null){
          listHotel!.add(hotel);
        }
      }
      if(listHotelFavorite != null && listHotel != null){
        emit(FavoriteLoaded(true));
      }
      else{
        emit(FavoriteLoaded(false));
      }
    });

    on<GetListCarFavoriteEvent>((event,emit) async {
      listCar = [];
      listCarFavorite = [];
      if(event.userId == null){
        emit(FavoriteLoaded(false));
        return;
      }
      var tempLs = await getListIdFavoriteByUserId("car", event.userId!);
      if(tempLs == null){
        emit(FavoriteLoaded(false));
        return;
      }
      for (var item in tempLs){
        var favoriteCar = await getFavoriteById(item);
        if(favoriteCar != null){
          listCarFavorite!.add(favoriteCar);
        }
      }
      for (var item in listCarFavorite!){
        var car = await getVehicleById(item.element!);
        if(car != null){
          listCar!.add(car);
        }
      }
      if(listCarFavorite != null && listCar != null){
        emit(FavoriteLoaded(true));
      }
      else{
        emit(FavoriteLoaded(false));
      }
    });

    on<GetListTourFavoriteEvent>((event, emit) async {
      listTour = [];
      listTourFavorite = [];
      if(event.userId == null){
        emit(FavoriteLoaded(false));
        return;
      }
      var tempLs = await getListIdFavoriteByUserId("tour", event.userId!);
      if(tempLs == null){
        emit(FavoriteLoaded(false));
        return;
      }
      for (var item in tempLs){
        var favoriteTour = await getFavoriteById(item);
        if(favoriteTour != null){
          listTourFavorite!.add(favoriteTour);
        }
      }
      for (var item in listTourFavorite!){
        var car = await getTourById(item.element!);
        if(car != null){
          listTour!.add(car);
        }
      }
      if(listTourFavorite != null && listTour != null){
        emit(FavoriteLoaded(true));
      }
      else{
        emit(FavoriteLoaded(false));
      }
    });
  }
  Future<List<String>?> getListIdFavoriteByUserId(String type,String userId) async{
    var favoriteRepo = GetIt.instance.get<FavoriteRepository>();
    try{
      var listIdFavorite = await favoriteRepo.getListFavoriteIdByUserId(type, userId);
      return listIdFavorite;
    }
    catch(e){
      print(e);
      return null;
    }
  }
  Future<Favorite?> getFavoriteById(String id) async{
    var favoriteRepo = GetIt.instance.get<FavoriteRepository>();
    try{
      var favorite = await favoriteRepo.getFavoriteById(id);
      return favorite;
    }
    catch(e){
      print(e);
      return null;
    }
  }
  Future<Hotel?> getHotelById(String id) async{
    var hotelRepo = GetIt.instance.get<HotelRepository>();
    try{
      var hotel = await hotelRepo.getHotelById(id);
      return hotel;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<Vehicle?> getVehicleById(String id) async {
    var vehicleRepo = GetIt.instance.get<VehicleRepository>();
    try{
      var vehicle = await vehicleRepo.getVehicleById(id);
      return vehicle;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<Tour?> getTourById(String id) async {
    var tourRepo = GetIt.instance.get<TourRepository>();
    try{
      var tour = await tourRepo.getTourById(id);
      return tour;
    }catch(e){
      print(e);
      return null;
    }
  }
}
