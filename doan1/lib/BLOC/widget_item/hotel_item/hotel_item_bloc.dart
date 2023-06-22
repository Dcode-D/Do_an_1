import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doan1/data/repositories/hotelroom_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/favorite.dart';
import '../../../data/model/hotel.dart';
import '../../../data/model/hotelroom.dart';
import '../../../data/repositories/favorite_repo.dart';
import '../../../data/repositories/hotel_repo.dart';

part 'hotel_item_event.dart';
part 'hotel_item_state.dart';

class HotelItemBloc extends Bloc<HotelItemEvent,HotelItemState> {
  Hotel? hotel;
  List<String>? listImage;
  List<HotelRoom>? listHotelRoom;
  Favorite? favorite;
  HotelItemBloc() : super(InitialHotelItemState()){
    listImage = [];
    on<GetHotelItemEvent>((event,emit)async{
      if(event.hotelId == null){
        emit(HotelItemGetState(getHotelItemSuccess: false));
        return;
      }
      var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
      hotel = await getHotelById(event.hotelId!);
      for (var item in hotel!.images!){
        listImage!.add('$baseUrl/files/$item');
      }
      if(hotel != null && listImage != null){
        emit(HotelItemGetState(getHotelItemSuccess: true));
      }
      else{
        emit(HotelItemGetState(getHotelItemSuccess: false));
      }
    });
    on<GetHotelRoomEvent>((event,emit) async {
      listHotelRoom = [];
      if(hotel == null){
        emit(HotelItemGetRoomState(getHotelRoomSuccess: false));
        return;
      }
      listHotelRoom = await getListHotelRoomFunc(hotel!.id!,event.startDate!,event.endDate!);
      if(listHotelRoom != null){
        emit(HotelItemGetRoomState(getHotelRoomSuccess: true));
      }
      else{
        emit(HotelItemGetRoomState(getHotelRoomSuccess: false));
      }
    });
    on<LikeHotelEvent>((event,emit) async {
      if(hotel == null){
        emit(HotelItemLoveState(loveHotelSuccess: false));
        return;
      }
      var result = await createFavoriteHotel(hotel!.id!,event.userId!);
      if(result == true){
        emit(HotelItemLoveState(loveHotelSuccess: true));
      }
      else{
        emit(HotelItemLoveState(loveHotelSuccess: false));
      }
    });
    on<DislikeHotelEvent>((event,emit) async {
      if(favorite == null){
        emit(HotelItemLoveState(loveHotelSuccess: false));
        return;
      }
      var result = await deleteFavoriteHotel(favorite!.id!);
      if(result == true){
        emit(HotelItemLoveState(loveHotelSuccess: false));
      }
      else{
        emit(HotelItemLoveState(loveHotelSuccess: true));
      }
    });
    on<GetHotelIsFavorite>((event,emit)async{
      if(hotel == null){
        emit(HotelItemGetFavoriteState(getHotelFavoriteSuccess: false));
        return;
      }
      var result = await isHotelFavorite(hotel!.id!);
      if (result == null){
        emit(HotelItemGetFavoriteState(getHotelFavoriteSuccess: false));
      }
      else{
        if(result == ""){
          emit(HotelItemGetFavoriteState(getHotelFavoriteSuccess: false));
          return;
        }
        favorite = await getFavoriteById(result);
        if(favorite == null){
          emit(HotelItemGetFavoriteState(getHotelFavoriteSuccess: false));
        }
        else{
          emit(HotelItemGetFavoriteState(getHotelFavoriteSuccess: true));
        }
      }
    });
  }
  Future<List<HotelRoom>?> getListHotelRoomFunc(String hotelID,String startDate,String endDate) async{
    var hotelRoomRepo = GetIt.instance.get<HotelRoomRepository>();
    try{
      var listHotelRoom = await hotelRoomRepo.getHotelRoomListWithDate(hotelID,startDate,endDate);
      return listHotelRoom;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<Hotel?> getHotelById(String id)async {
    var hotelRepo = GetIt.instance.get<HotelRepository>();
    try{
      var hotel = await hotelRepo.getHotelById(id);
      return hotel;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<bool> createFavoriteHotel(String hotelId,String userId) async{
    var favoriteRepo = GetIt.instance.get<FavoriteRepository>();
    try{
      var result = await favoriteRepo.createFavorite("hotel",userId,hotelId);
      return result;
    }catch(e){
      print(e);
      return false;
    }
  }
  Future<bool> deleteFavoriteHotel(String favoriteHotelId) async{
    var favoriteRepo = GetIt.instance.get<FavoriteRepository>();
    try{
      var result = await favoriteRepo.deleteFavorite(favoriteHotelId);
      return result;
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<String?> isHotelFavorite(String hotelId) async {
    var favoriteRepo = GetIt.instance.get<FavoriteRepository>();
    try{
      var result = await favoriteRepo.getIsFavoriteByService("hotel",hotelId);
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