part of 'edit_vehicle_item_bloc.dart';

@immutable
abstract class EditVehicleItemEvent {}

class GetVehicleItemEvent extends EditVehicleItemEvent {
  final String vehicleId;
  GetVehicleItemEvent({required this.vehicleId});
}

class VehicleItemDeleteEvent extends EditVehicleItemEvent {
  final String vehicleId;
  VehicleItemDeleteEvent(this.vehicleId);
}

class VehicleItemRefreshEvent extends EditVehicleItemEvent {
  VehicleItemRefreshEvent();
}

class VehicleItemDeleteImageEvent extends EditVehicleItemEvent {
  final int index;
  VehicleItemDeleteImageEvent(this.index);
}

class VehicleItemAddImageEvent extends EditVehicleItemEvent {
  final ImagePickMethod method;
  VehicleItemAddImageEvent(this.method);
}

class VehicleItemEditEvent extends EditVehicleItemEvent{
  final String brand;
  final double price;
  final String color;
  final String description;
  final String address;
  final int seats;
  VehicleItemEditEvent(this.brand, this.price, this.color, this.description, this.address, this.seats);
}