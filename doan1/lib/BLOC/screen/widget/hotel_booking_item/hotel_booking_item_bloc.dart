import 'package:doan1/data/repositories/hotel_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../../../../data/model/datebooking.dart';
import '../../../../data/model/hotel.dart';
import '../../../../data/model/hotelroom.dart';
import '../../../../data/repositories/datebooking_repo.dart';
import '../../../../data/repositories/hotelroom_repo.dart';

part 'hotel_booking_item_event.dart';
part 'hotel_booking_item_state.dart';

class HotelBookingItemBloc extends Bloc<HotelBookingItemEvent,HotelBookingItemState> {
  DateBooking? dateBooking;
  List<HotelRoom>? lsHotelRoom;
  Hotel? hotel;
  HotelBookingItemBloc() : super(HotelBookingItemInitial(getDataSuccess: false)) {
    on<HotelBookingItemInitialEvent>((event,emit) async {
      lsHotelRoom = [];
      dateBooking = event.dateBooking;
      for (String room in event.dateBooking!.attachedServices!) {
        lsHotelRoom!.add(await getHotelRoomFunc(room) as HotelRoom);
      }
      hotel = await getHotelFunc(lsHotelRoom![0].hotel!);
      if(hotel != null && lsHotelRoom != null){
        emit(HotelBookingItemInitial(getDataSuccess: true));
      }
      else{
        emit(HotelBookingItemInitial(getDataSuccess: false));
      }
    });
    on<HotelBookingItemRejectEvent>((event,emit) async{
      bool? rejectSuccess = await rejectDateBookingFunc(dateBooking!.id!);
      if(rejectSuccess == true){
        emit(HotelBookingItemRejectSuccess(rejectSuccess: true));
      }
      else{
        emit(HotelBookingItemRejectSuccess(rejectSuccess: false));
      }
    });
  }

  Future<HotelRoom?> getHotelRoomFunc(String hotelRoomId) async{
    return GetIt.instance<HotelRoomRepo>().getHotelRoomById(hotelRoomId).then((value) {
      if(value != null){
        return value;
      }
      else{
        return null;
      }
    });
  }

  Future<Hotel?> getHotelFunc(String hotelId) async{
    var hotelRepo = GetIt.instance<HotelRepo>();
    try{
      hotel = await hotelRepo.getHotelById(hotelId);
      return hotel;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future<bool?> rejectDateBookingFunc(String dateBookingId) async{
    return GetIt.instance<DateBookingRepo>().RejectBookingDate(dateBookingId);
  }
}