import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doan1/data/repositories/hotel_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/hotel.dart';
import '../../../data/model/hotelroom.dart';
import '../../../data/repositories/hotelroom_repo.dart';

part 'edit_hotel_item_event.dart';
part 'edit_hotel_item_state.dart';

class EditHotelItemBloc extends Bloc<EditHotelItemEvent,EditHotelItemState>{
  Hotel? hotel;
  List<String>? images;
  List<HotelRoom>? listHotelRoom;
  int? index;
  EditHotelItemBloc() : super(EditHotelItemInitial()){
    on<GetHotelItemEvent>((event,emit) async {
      images = [];
      if(event.hotel == null){
        emit(EditHotelItemLoaded(false));
        return;
      }
      var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
      emit(EditHotelItemLoaded(false));
      // hotel = await getHotelById(event.hotelId);
      hotel = event.hotel;
      index = event.index;
      for (var item in hotel!.images!){
        images!.add('$baseUrl/files/$item');
      }
      listHotelRoom = await getListHotelRoomFunc(hotel!.id!);

      if(hotel != null && images != null && listHotelRoom != null){
        emit(EditHotelItemLoaded(true));
      }
      else{
        emit(EditHotelItemLoaded(false));
      }
    });
    on<DeleteHotelItemEvent>((event,emit) async{
      if(event.hotelId == null){
        emit(DeleteHotelItemState(false));
        return;
      }
      bool? result = await deleteHotelById(event.hotelId);
      if(result == true){
        emit(DeleteHotelItemState(true));
      }
      else{
        emit(DeleteHotelItemState(false));
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

  Future<bool?> deleteHotelById(String id) async{
    var hotelRepo = GetIt.instance.get<HotelRepo>();
    try{
      var result = await hotelRepo.DeleteHotelById(id);
      return result;
    }catch(e){
      print(e);
      return null;
    }
  }
}