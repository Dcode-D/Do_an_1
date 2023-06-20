import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doan1/BLOC/profile/favorite/favorite_bloc.dart';
import 'package:doan1/data/repositories/hotelroom_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/hotel.dart';
import '../../../data/model/hotelroom.dart';
import '../../../data/repositories/favorite_repo.dart';

part 'hotel_item_event.dart';
part 'hotel_item_state.dart';

class HotelItemBloc extends Bloc<HotelItemEvent,HotelItemState> {
  Hotel? hotel;
  List<String>? listImage;
  List<HotelRoom>? listHotelRoom;
  HotelItemBloc() : super(InitialHotelItemState()){
    listImage = [];
    on<GetHotelItemEvent>((event,emit)async{
      if(event.hotel == null){
        emit(HotelItemGetState(getHotelItemSuccess: false));
        return;
      }
      var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
      hotel = event.hotel;
      for (var item in hotel!.images!){
        listImage!.add('$baseUrl/files/${item}');
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
    on<LoveHotelEvent>((event,emit) async {
      if(hotel == null){
        emit(HotelItemLoveState(loveHotelSuccess: false));
        return;
      }
      // var result = await loveHotelFunc(hotel!.id!);
      // if(result == true){
      //   emit(HotelItemLoveState(loveHotelSuccess: true));
      // }
      // else{
      //   emit(HotelItemLoveState(loveHotelSuccess: false));
      // }
    });
  }
  Future<List<HotelRoom>?> getListHotelRoomFunc(String hotelID,String startDate,String endDate) async{
    var hotelRoomRepo = GetIt.instance.get<HotelRoomRepo>();
    try{
      var listHotelRoom = await hotelRoomRepo.getHotelRoomListWithDate(hotelID,startDate,endDate);
      return listHotelRoom;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<bool> createFavoriteHotel(String hotelId,String userId) async{
    var favoriteRepo = GetIt.instance.get<FavoriteRepo>();
    try{
      var result = await favoriteRepo.createFavorite("hotel",userId,hotelId);
      return result;
    }catch(e){
      print(e);
      return false;
    }
  }
  Future<bool> deleteFavoriteHotel(String favoriteHotelId) async{
    var favoriteRepo = GetIt.instance.get<FavoriteRepo>();
    try{
      var result = await favoriteRepo.deleteFavorite(favoriteHotelId);
      return result;
    }catch(e){
      print(e);
      return false;
    }
  }
}