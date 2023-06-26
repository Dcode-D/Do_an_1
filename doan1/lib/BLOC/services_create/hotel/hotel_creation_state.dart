part of 'hotel_creation_bloc.dart';

@immutable
abstract class HotelCreationState {}

class HotelCreationInitial extends HotelCreationState {}

class HotelCreationImageState extends HotelCreationState {
  final List<File> listImages;
  HotelCreationImageState(this.listImages);
}

class HotelCreationPostState extends HotelCreationState {
  final bool success;
  final String hotelid;
  HotelCreationPostState(this.success, this.hotelid);
}
