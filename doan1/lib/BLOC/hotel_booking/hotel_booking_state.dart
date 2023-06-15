part of 'hotel_booking_bloc.dart';

enum BookingState{
  initial,
  success,
  failure
}

class HotelBookingState{
  bool isDateSet = false;
  bool isRoomSet = false;
  BookingState isBookingSuccess = BookingState.initial;
  HotelBookingState({required this.isDateSet, required this.isRoomSet,required this.isBookingSuccess});
}