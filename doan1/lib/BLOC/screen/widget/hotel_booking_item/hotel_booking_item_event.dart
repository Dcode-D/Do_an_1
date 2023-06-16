part of 'hotel_booking_item_bloc.dart';

@immutable
abstract class HotelBookingItemEvent {}

class HotelBookingItemInitialEvent extends HotelBookingItemEvent {
  DateBooking? dateBooking;
  HotelBookingItemInitialEvent({required this.dateBooking});
}

class HotelBookingItemRejectEvent extends HotelBookingItemEvent {
}