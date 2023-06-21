part of 'hotel_item_bloc.dart';

@immutable
abstract class HotelItemState{}

class InitialHotelItemState extends HotelItemState{}

class HotelItemGetState extends HotelItemState{
  bool getHotelItemSuccess;
  HotelItemGetState({required this.getHotelItemSuccess});
}

class HotelItemGetRoomState extends HotelItemState{
  bool getHotelRoomSuccess;
  HotelItemGetRoomState({required this.getHotelRoomSuccess});
}

class HotelItemGetFavoriteState extends HotelItemState{
  bool getHotelFavoriteSuccess;
  HotelItemGetFavoriteState({required this.getHotelFavoriteSuccess});
}

class HotelItemLoveState extends HotelItemState{
  bool loveHotelSuccess;
  HotelItemLoveState({required this.loveHotelSuccess});
}
