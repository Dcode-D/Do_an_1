import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'hotel_booking_event.dart';
part 'hotel_booking_state.dart';

class HotelBookingBloc extends Bloc<HotelBookingEvent, HotelBookingState>{

  HotelBookingBloc() : super(HotelBookingState(isPayAtHotel: false)) {
    on<CheckPayAtHotelEvent>((event, emit) => emit(HotelBookingState(isPayAtHotel: event.isPayAtHotel)));
    on<UnCheckPayAtHotellEvent>((event, emit) => emit(HotelBookingState(isPayAtHotel: event.isPayAtHotel)));
  }
}