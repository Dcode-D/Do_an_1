part of 'hotel_item_bloc.dart';

@immutable
abstract class HotelItemEvent{}

class GetHotelItemEvent extends HotelItemEvent {
  Hotel? hotel;
  GetHotelItemEvent({required this.hotel});
}

class GetHotelRoomEvent extends HotelItemEvent {
  String? startDate;
  String? endDate;
  GetHotelRoomEvent({required this.startDate,required this.endDate});
}

class GetHotelIsFavorite extends HotelItemEvent {}

class LikeHotelEvent extends HotelItemEvent {
  String? userId;
  LikeHotelEvent({required this.userId});
}

class DislikeHotelEvent extends HotelItemEvent {
}