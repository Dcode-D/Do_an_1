part of 'hotel_booking_bloc.dart';
@immutable
abstract class HotelBookingEvent {}

class SetBookingDate extends HotelBookingEvent{}

class SetRoom extends HotelBookingEvent{
  List<HotelRoom> hotelRoom = [];
  SetRoom({required this.hotelRoom});
}