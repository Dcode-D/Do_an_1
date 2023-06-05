part of 'vehicle_creation_bloc.dart';
enum ImageMethod { gallery, camera }

@immutable
abstract class VehicleCreationEvent {}

class VehicleCreationImageEvent extends VehicleCreationEvent {
  final ImageMethod method;
  VehicleCreationImageEvent(this.method);
}
class VehicleCreationImgRemoveEvent extends VehicleCreationEvent {
  final int index;
  VehicleCreationImgRemoveEvent(this.index);
}
class VehicleCreationPostEvent extends VehicleCreationEvent {
  final Map<String, dynamic> data;
  VehicleCreationPostEvent(this.data);
}
