part of 'vehicle_booking_bloc.dart';

enum BookingState{
  initial, success, failure
}

class VehicleBookingState{
  bool isDateSet = false;
  BookingState isBookingSuccess = BookingState.initial;
  VehicleBookingState({required this.isDateSet,required this.isBookingSuccess});
}