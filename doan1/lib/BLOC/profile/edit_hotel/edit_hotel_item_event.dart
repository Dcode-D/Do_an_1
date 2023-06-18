part of 'edit_hotel_item_bloc.dart';

@immutable
abstract class EditHotelItemEvent {}

class GetHotelItemEvent extends EditHotelItemEvent {
  final String hotelId;
  GetHotelItemEvent(this.hotelId);
}

class DeleteHotelItemEvent extends EditHotelItemEvent {
  final String hotelId;
  DeleteHotelItemEvent(this.hotelId);
}

