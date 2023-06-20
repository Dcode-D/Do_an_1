part of 'edit_vehicle_item_bloc.dart';

@immutable
abstract class EditVehicleItemEvent {}

class GetVehicleItemEvent extends EditVehicleItemEvent {
  final String vehicleId;
  int index;
  GetVehicleItemEvent({required this.vehicleId,required this.index});
}

class VehicleItemDeleteEvent extends EditVehicleItemEvent {
  final String vehicleId;
  VehicleItemDeleteEvent(this.vehicleId);
}