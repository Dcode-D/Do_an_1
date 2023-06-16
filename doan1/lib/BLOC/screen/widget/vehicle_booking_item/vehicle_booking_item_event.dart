part of 'vehicle_booking_item_bloc.dart';

@immutable
abstract class VehicleBookingItemEvent {}

class VehicleBookingItemInitialEvent extends VehicleBookingItemEvent {
  DateBooking? dateBooking;
  VehicleBookingItemInitialEvent({required this.dateBooking});
}