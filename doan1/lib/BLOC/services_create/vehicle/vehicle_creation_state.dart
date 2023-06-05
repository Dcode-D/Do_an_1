part of 'vehicle_creation_bloc.dart';

@immutable
abstract class VehicleCreationState {}

class VehicleCreationInitial extends VehicleCreationState {}
class VehicleCreationImageState extends VehicleCreationState {
  final List<File> listImages;
  VehicleCreationImageState(this.listImages);
}

class VehicleCreationPostState extends VehicleCreationState {
  final bool success;
  VehicleCreationPostState(this.success);
}
