import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
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
  EditHotelItemBloc() : super(EditHotelItemInitial()){
    images = [];
    on<GetHotelItemEvent>((event,emit) async {
      if(event.hotel == null){
        emit(EditHotelItemLoaded(false));
        return;
      }
      var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
      emit(EditHotelItemLoaded(false));
      hotel = event.hotel;
      for (var item in hotel!.images!){
        images!.add('$baseUrl/files/${item}');
      }
      listHotelRoom = await getListHotelRoomFunc(hotel!.id!);

      if(hotel != null && images != null && listHotelRoom != null){
        emit(EditHotelItemLoaded(true));
      }
      else{
        emit(EditHotelItemLoaded(false));
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