part of 'create_hotel_rooms_bloc.dart';

@immutable
abstract class CreateHotelRoomsEvent {}

class CreateHotelRoomsInitialHotelEvent extends CreateHotelRoomsEvent {
  final String hotelId;
  CreateHotelRoomsInitialHotelEvent(this.hotelId);
}

class CreateHotelRoomsAddRoomEvent extends CreateHotelRoomsEvent {
  final HotelRoom hotelRoom;
  CreateHotelRoomsAddRoomEvent(this.hotelRoom);
}

class CreateHotelRoomsRemoveRoomEvent extends CreateHotelRoomsEvent {
  final HotelRoom hotelRoom;
  CreateHotelRoomsRemoveRoomEvent(this.hotelRoom);
}

class CreateHotelRoomsPostEvent extends CreateHotelRoomsEvent {
  CreateHotelRoomsPostEvent();
}

class CreateHotelRoomsCopyEvent extends CreateHotelRoomsEvent {
  final HotelRoom hotelRoom;
  CreateHotelRoomsCopyEvent(this.hotelRoom);
}
