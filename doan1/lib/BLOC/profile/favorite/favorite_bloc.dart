import 'package:bloc/bloc.dart';
import 'package:doan1/data/model/favorite.dart';
import 'package:doan1/data/repositories/favorite_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/hotel.dart';
import '../../../data/model/vehicle.dart';
import '../../../data/repositories/hotel_repo.dart';
import '../../../data/repositories/vehicle_repo.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  List<Hotel>? listHotel;
  List<Vehicle>? listCar;
  List<Favorite>? listHotelFavorite;
  List<Favorite>? listCarFavorite;
  // List<Tour>? listTourFavorite;
  FavoriteBloc() : super(FavoriteInitial()){
    on<GetListHotelFavoriteEvent>((event,emit){
      listHotel = [];
      listHotelFavorite = [];
      if(event.userId == null){
        emit(FavoriteLoaded(false));
        return;
      }
      getListIdFavoriteByUserId("hotel", event.userId!).then((value) async {
        if(value == null){
          emit(FavoriteLoaded(false));
          return;
        }
        for (var item in value){
          var hotel = await getHotelById(item);
          if(hotel != null){
            listHotel!.add(hotel);
          }
        }
        for (var item in listHotel!){
          var favorite = await getFavoriteById(item.id!);
          if(favorite != null){
            listHotelFavorite!.add(favorite);
          }
        }
        if(listHotelFavorite != null){
          emit(FavoriteLoaded(true));
        }
        else{
          emit(FavoriteLoaded(false));
        }
      });
    });

    on<GetListCarFavoriteEvent>((event,emit){
      listCar = [];
      listCarFavorite = [];
      if(event.userId == null){
        emit(FavoriteLoaded(false));
        return;
      }
      getListIdFavoriteByUserId("vehicle", event.userId!).then((value) async {
        if(value == null){
          emit(FavoriteLoaded(false));
          return;
        }
        for (var item in value){
          var car = await getVehicleById(item);
          if(car != null){
            listCar!.add(car);
          }
        }
        for (var item in listCar!){
          var favorite = await getFavoriteById(item.id!);
          if(favorite != null){
            listCarFavorite!.add(favorite);
          }
        }
        if(listCarFavorite != null){
          emit(FavoriteLoaded(true));
        }
        else{
          emit(FavoriteLoaded(false));
        }
      });
    });

    on<GetListTourFavoriteEvent>((event, emit) {

    });
  }
  Future<List<String>?> getListIdFavoriteByUserId(String type,String userId) async{
    var favoriteRepo = GetIt.instance.get<FavoriteRepo>();
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
    var favoriteRepo = GetIt.instance.get<FavoriteRepo>();
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
    var hotelRepo = GetIt.instance.get<HotelRepo>();
    try{
      var hotel = await hotelRepo.getHotelById(id);
      return hotel;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<Vehicle?> getVehicleById(String id) async {
    var vehicleRepo = GetIt.instance.get<VehicleRepo>();
    try{
      var vehicle = await vehicleRepo.getVehicleById(id);
      return vehicle;
    }catch(e){
      print(e);
      return null;
    }
  }
}
