part of 'hotel_booking_item_bloc.dart';

@immutable
abstract class HotelBookingItemState {}

class HotelBookingItemInitial extends HotelBookingItemState {
  bool getDataSuccess = false;
  HotelBookingItemInitial({required this.getDataSuccess});
}

