part of 'edit_vehicle_item_bloc.dart';

@immutable
abstract class EditVehicleItemEvent {}

class GetVehicleItemEvent extends EditVehicleItemEvent {
  final Vehicle vehicle;
  GetVehicleItemEvent(this.vehicle);
}