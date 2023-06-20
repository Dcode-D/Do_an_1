import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doan1/data/repositories/hotelroom_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/hotel.dart';
import '../../../data/model/hotelroom.dart';

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
      listHotelRoom = await getListHotelRoomFunc(hotel!.id!);
      if(listHotelRoom != null){
        emit(HotelItemGetRoomState(getHotelRoomSuccess: true));
      }
      else{
        emit(HotelItemGetRoomState(getHotelRoomSuccess: false));
      }
    });
  }
  Future<List<HotelRoom>?> getListHotelRoomFunc(String hotelID) async{
    var hotelRoomRepo = GetIt.instance.get<HotelRoomRepo>();
    try{
      var listHotelRoom = await hotelRoomRepo.getHotelRoomList(hotelID);
      return listHotelRoom;
    }catch(e){
      print(e);
      return null;
    }
  }
}