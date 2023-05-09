part of 'vehicle_rent_bloc.dart';
@immutable
abstract class VehicleRentEvent {}

class CheckNeedDriverEvent extends VehicleRentEvent {
  bool needDriver = true;
  CheckNeedDriverEvent({required this.needDriver});
}

class UnCheckNeedDriverlEvent extends VehicleRentEvent {
  bool needDriver = false;
  UnCheckNeedDriverlEvent({required this.needDriver});
}