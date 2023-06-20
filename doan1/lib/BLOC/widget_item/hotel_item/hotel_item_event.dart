part of 'hotel_item_bloc.dart';

@immutable
abstract class HotelItemEvent{}

class GetHotelItemEvent extends HotelItemEvent {
  Hotel? hotel;
  GetHotelItemEvent({required this.hotel});
}

class GetHotelRoomEvent extends HotelItemEvent {}