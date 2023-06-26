part of 'create_hotel_rooms_bloc.dart';

@immutable
abstract class CreateHotelRoomsState {}

class CreateHotelRoomsInitial extends CreateHotelRoomsState {}

class CreateHotelRoomsReadyState extends CreateHotelRoomsState {
  final bool isloading;
  final bool isready;
  CreateHotelRoomsReadyState(this.isloading, this.isready);
}

class CreateHotelRoomsListRoomsChangedState extends CreateHotelRoomsState {
  final List<HotelRoom> hotelRooms;
  CreateHotelRoomsListRoomsChangedState(this.hotelRooms);
}

class CreateHotelRoomsSuccessState extends CreateHotelRoomsState {
  final bool isSuccess;
  final bool isloading;
  CreateHotelRoomsSuccessState(this.isSuccess, this.isloading);
}

class CreateHotelRoomsCopyState extends CreateHotelRoomsState {
  final HotelRoom hotelRoom;
  CreateHotelRoomsCopyState(this.hotelRoom);
}
