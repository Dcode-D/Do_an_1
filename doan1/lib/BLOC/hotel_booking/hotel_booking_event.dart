part of 'hotel_booking_bloc.dart';
@immutable
abstract class HotelBookingEvent {}

class CheckPayAtHotelEvent extends HotelBookingEvent {
  bool isPayAtHotel = true;
  CheckPayAtHotelEvent({required this.isPayAtHotel});
}

class UnCheckPayAtHotellEvent extends HotelBookingEvent {
  bool isPayAtHotel = false;
  UnCheckPayAtHotellEvent({required this.isPayAtHotel});
}