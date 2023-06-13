part of 'hotel_creation_bloc.dart';
enum ImageMethod { gallery, camera }

@immutable
abstract class HotelCreationEvent {}

class HotelCreationImageEvent extends HotelCreationEvent {
  final ImageMethod method;
  HotelCreationImageEvent(this.method);
}

class HotelCreationRemoveImgEvent extends HotelCreationEvent {
  final int index;
  HotelCreationRemoveImgEvent(this.index);
}

class HotelCreationPostEvent extends HotelCreationEvent{
  final String name;
  final String description;
  final String address;
  final String province;
  final String district;
  final List<String> facilities;
  HotelCreationPostEvent({required this.name,required this.description,required this.address,required this.province,required this.district, required this.facilities});
}
