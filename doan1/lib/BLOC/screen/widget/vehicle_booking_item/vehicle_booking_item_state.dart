part of 'vehicle_booking_item_bloc.dart';

@immutable
abstract class VehicleBookingItemState {}

class VehicleBookingItemInitial extends VehicleBookingItemState {
  bool getDataSuccess = false;
  VehicleBookingItemInitial({required this.getDataSuccess});
}

class VehicleBookingItemRejectSuccess extends VehicleBookingItemState {
  bool rejectSuccess = false;
  VehicleBookingItemRejectSuccess({required this.rejectSuccess});
}

class VehicleBookingItemDeleteSuccess extends VehicleBookingItemState {
  bool deleteSuccess = false;
  VehicleBookingItemDeleteSuccess({required this.deleteSuccess});
}

class VehicleBookingItemApproveSuccess extends VehicleBookingItemState {
  bool approveSuccess = false;
  VehicleBookingItemApproveSuccess({required this.approveSuccess});
}