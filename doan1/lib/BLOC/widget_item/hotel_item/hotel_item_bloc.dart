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
  HotelItemBloc() : super(HotelItemState(getHotelItemSuccess: false)){
    listImage = [];
    on<GetHotelItemEvent>((event,emit)async{
      if(event.hotel == null|| event.hotel!.images == null){
        emit(HotelItemState(getHotelItemSuccess: false));
        return;
      }
      var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
      emit(HotelItemState(getHotelItemSuccess: false));
      hotel = event.hotel;
      for (var item in hotel!.images!){
        listImage!.add('$baseUrl/files/${item}');
      }
      listHotelRoom = await getListHotelRoomFunc(hotel!.id!);
      if(hotel != null && listImage != null && listHotelRoom != null){
        emit(HotelItemState(getHotelItemSuccess: true));
      }
      else{
        emit(HotelItemState(getHotelItemSuccess: false));
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