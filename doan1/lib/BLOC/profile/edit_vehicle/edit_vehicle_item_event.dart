part of 'edit_vehicle_item_bloc.dart';

@immutable
abstract class EditVehicleItemEvent {}

class GetVehicleItemEvent extends EditVehicleItemEvent {
  final String vehicleId;
  GetVehicleItemEvent(this.vehicleId);
}

class VehicleItemDeleteEvent extends EditVehicleItemEvent {
  final String vehicleId;
  VehicleItemDeleteEvent(this.vehicleId);
}