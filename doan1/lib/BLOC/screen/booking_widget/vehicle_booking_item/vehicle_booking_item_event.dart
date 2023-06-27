part of 'vehicle_booking_item_bloc.dart';

@immutable
abstract class VehicleBookingItemEvent {}

class VehicleBookingItemInitialEvent extends VehicleBookingItemEvent {
  DateBooking? dateBooking;
  int? index;
  VehicleBookingItemInitialEvent({required this.dateBooking, required this.index});
}

class VehicleBookingItemRejectEvent extends VehicleBookingItemEvent {}

class VehicleBookingItemDeleteEvent extends VehicleBookingItemEvent {}

class VehicleBookingItemApproveEvent extends VehicleBookingItemEvent {}

class VehicleBookingItemRefreshEvent extends VehicleBookingItemEvent {}