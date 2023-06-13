part of 'hotel_booking_bloc.dart';
@immutable
abstract class HotelBookingEvent {}

class SetBookingDate extends HotelBookingEvent{}

class SetRoomEvent extends HotelBookingEvent{
  List<HotelRoom> hotelRoom = [];
  SetRoomEvent({required this.hotelRoom});
}

class RemoveRoomEvent extends HotelBookingEvent{
  int index;
  RemoveRoomEvent({required this.index});
}