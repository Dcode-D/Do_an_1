import 'package:dio/dio.dart';
import 'package:doan1/data/repositories/vehicle_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../../../data/model/favorite.dart';
import '../../../data/model/vehicle.dart';
import '../../../data/repositories/favorite_repo.dart';

part 'car_item_event.dart';
part 'car_item_state.dart';

class CarItemBloc extends Bloc<CarItemEvent,CarItemState>{
  Vehicle? vehicle;
  List<String>? listImage;
  Favorite? favorite;
  CarItemBloc() : super(InitialCarItemState()){
    listImage = [];
    on<GetCarItemEvent>((event, emit) async {
      if(event.vehicleId == null){
        emit(CarItemGetState(getCarItemSuccess: false));
        return;
      }
      var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
      vehicle = await getVehicleById(event.vehicleId!);

      for (var item in vehicle!.images!){
        listImage!.add('$baseUrl/files/$item');
      }
      if(vehicle != null){
        emit(CarItemGetState(getCarItemSuccess: true));
      }
      else{
        emit(CarItemGetState(getCarItemSuccess: false));
      }
    });
    on<LikeCarEvent>((event,emit) async {
      if(vehicle == null){
        emit(CarItemLoveState(loveCarSuccess: false));
        return;
      }
      var result = await createFavoriteHotel(vehicle!.id!,event.userId!);
      if(result == true){
        emit(CarItemLoveState(loveCarSuccess: true));
      }
      else{
        emit(CarItemLoveState(loveCarSuccess: false));
      }
    });
    on<DislikeCarEvent>((event,emit) async {
      if(favorite == null){
        emit(CarItemLoveState(loveCarSuccess: false));
        return;
      }
      var result = await deleteFavoriteHotel(favorite!.id!);
      if(result == true){
        emit(CarItemLoveState(loveCarSuccess: false));
      }
      else{
        emit(CarItemLoveState(loveCarSuccess: true));
      }
    });
    on<GetCarIsFavorite>((event,emit)async{
      if(vehicle == null){
        emit(CarItemGetFavoriteState(getCarFavoriteSuccess: false));
        return;
      }
      var result = await isCarFavorite(vehicle!.id!);
      if (result == null){
        emit(CarItemGetFavoriteState(getCarFavoriteSuccess: false));
      }
      else{
        if(result == ""){
          emit(CarItemGetFavoriteState(getCarFavoriteSuccess: false));
          return;
        }
        favorite = await getFavoriteById(result);
        if(favorite == null){
          emit(CarItemGetFavoriteState(getCarFavoriteSuccess: false));
        }
        else{
          emit(CarItemGetFavoriteState(getCarFavoriteSuccess: true));
        }
      }
    });
  }

  Future<Vehicle?> getVehicleById(String id) async {
    var vehicleRepo = await GetIt.instance.get<VehicleRepository>();
    try{
      var vehicle = await vehicleRepo.getVehicleById(id);
      return vehicle;
    }
    catch(e){
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool> createFavoriteHotel(String carId,String userId) async{
    var favoriteRepo = GetIt.instance.get<FavoriteRepository>();
    try{
      var result = await favoriteRepo.createFavorite("car",userId,carId);
      return result;
    }catch(e){
      print(e);
      return false;
    }
  }
  Future<bool> deleteFavoriteHotel(String favoriteCarId) async{
    var favoriteRepo = GetIt.instance.get<FavoriteRepository>();
    try{
      var result = await favoriteRepo.deleteFavorite(favoriteCarId);
      return result;
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<String?> isCarFavorite(String carId) async {
    var favoriteRepo = GetIt.instance.get<FavoriteRepository>();
    try{
      var result = await favoriteRepo.getIsFavoriteByService("car",carId);
      return result;
    }catch(e){
      print(e);
      return null;
    }
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
}