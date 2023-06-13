
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/hotelroom.dart';

part 'hotel_booking_event.dart';
part 'hotel_booking_state.dart';

class HotelBookingBloc extends Bloc<HotelBookingEvent, HotelBookingState>{
  List<HotelRoom> listSelectedHotelRoom = [];
  HotelBookingBloc() : super(HotelBookingState(isDateSet: false,isRoomSet: false)) {
    on<SetBookingDate>((event,emit) => emit(HotelBookingState(isDateSet: true,isRoomSet: state.isRoomSet)));
    on<SetRoomEvent>((event,emit) {
      listSelectedHotelRoom = event.hotelRoom;
      emit(HotelBookingState(isDateSet: state.isDateSet,isRoomSet: true));
    });
    on<RemoveRoomEvent>((event,emit) {
      listSelectedHotelRoom.removeAt(event.index);
      add(SetRoomEvent(hotelRoom: listSelectedHotelRoom));
    });
  }
}