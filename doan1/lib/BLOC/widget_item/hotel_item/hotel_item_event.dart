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

class LoveHotelEvent extends HotelItemEvent {
  String? hotelId;
  LoveHotelEvent({required this.hotelId});
}