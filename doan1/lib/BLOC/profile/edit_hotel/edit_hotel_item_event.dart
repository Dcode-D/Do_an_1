part of 'edit_hotel_item_bloc.dart';

@immutable
abstract class EditHotelItemEvent {}

class GetHotelItemEvent extends EditHotelItemEvent {
  final Hotel hotel;
  GetHotelItemEvent({required this.hotel});
}

class UpdateHotelRoomEvent extends EditHotelItemEvent {
  final int index;
  final HotelRoom hotelRoom;
  UpdateHotelRoomEvent({required this.index, required this.hotelRoom});
}

class DeleteHotelRoomEvent extends EditHotelItemEvent {
  final int index;
  DeleteHotelRoomEvent(this.index);
}

class DeleteHotelItemEvent extends EditHotelItemEvent {
  final String hotelId;
  DeleteHotelItemEvent(this.hotelId);
}

class RefreshHotelItemEvent extends EditHotelItemEvent {
  RefreshHotelItemEvent();
}

class DeleteHotelImageEvent extends EditHotelItemEvent {
  final int index;
  DeleteHotelImageEvent(this.index);
}

class AddImageEvent extends EditHotelItemEvent {
  final ImagePickMethod method;
  AddImageEvent(this.method);
}

class SaveHotelInfoEvent extends EditHotelItemEvent {
  final String name;
  final String address;
  final String description;
  final String facilities;
  SaveHotelInfoEvent({required this.name, required this.address, required this.description, required this.facilities});
}

