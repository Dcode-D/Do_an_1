
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../data/model/hotelroom.dart';
import '../../data/repositories/datebooking_repo.dart';

part 'hotel_booking_event.dart';
part 'hotel_booking_state.dart';

class HotelBookingBloc extends Bloc<HotelBookingEvent, HotelBookingState>{
  List<HotelRoom> listSelectedHotelRoom = [];
  HotelBookingBloc() : super(HotelBookingState(isDateSet: false,isRoomSet: false,isBookingSuccess: BookingState.initial)) {
    on<SetBookingDate>((event,emit) => emit(HotelBookingState(isDateSet: true,isRoomSet: state.isRoomSet,isBookingSuccess: state.isBookingSuccess)));
    on<SetRoomEvent>((event,emit) {
      listSelectedHotelRoom = event.hotelRoom;
      emit(HotelBookingState(isDateSet: state.isDateSet,isRoomSet: true,isBookingSuccess: state.isBookingSuccess));
    });
    on<RemoveRoomEvent>((event,emit) {
      listSelectedHotelRoom.removeAt(event.index);
      add(SetRoomEvent(hotelRoom: listSelectedHotelRoom));
    });
    on<BookingRoomEvent>((event,emit) async {
      emit(HotelBookingState(isDateSet: state.isDateSet,isRoomSet: state.isRoomSet,isBookingSuccess: BookingState.initial));
      bool? bookResult = await CreateHotelBooking(
          event.attachedServices!,
          event.startDate!,
          event.endDate!,
          event.user!,
          event.note,
          event.approved!,
          event.suspended!,
          event.type!);
      if(bookResult == true){
        emit(HotelBookingState(isDateSet: state.isDateSet,isRoomSet: state.isRoomSet,isBookingSuccess: BookingState.success));
      }
      else{
        emit(HotelBookingState(isDateSet: state.isDateSet,isRoomSet: state.isRoomSet,isBookingSuccess: BookingState.failure));
      }
    });

  }
  Future<bool?> CreateHotelBooking(List<String> attachedServices,String startDate,String endDate,String user,String note,bool approved,bool suspended,String type) async{
    DateBookingRepository dateBookingRepo = GetIt.instance.get<DateBookingRepository>();
    try{
      var result = await dateBookingRepo.CreateBookingDate(attachedServices, startDate, endDate, user, note, approved, suspended, type);
      return result;
    }catch(e){
      print(e);
      return null;
    }
  }
}