part of 'vehicle_booking_item_bloc.dart';

@immutable
abstract class VehicleBookingItemState {}

class VehicleBookingItemInitial extends VehicleBookingItemState {
  bool getDataSuccess = false;
  VehicleBookingItemInitial({required this.getDataSuccess});
}