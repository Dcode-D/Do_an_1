part of 'hotel_booking_item_bloc.dart';

@immutable
abstract class HotelBookingItemEvent {}

class HotelBookingItemInitialEvent extends HotelBookingItemEvent {
  DateBooking? dateBooking;
  int? index;
  HotelBookingItemInitialEvent({required this.dateBooking, required this.index});
}

class HotelBookingItemRejectEvent extends HotelBookingItemEvent {}

class HotelBookingItemDeleteEvent extends HotelBookingItemEvent {}