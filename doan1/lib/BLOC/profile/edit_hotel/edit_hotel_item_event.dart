part of 'edit_hotel_item_bloc.dart';

@immutable
abstract class EditHotelItemEvent {}

class GetHotelItemEvent extends EditHotelItemEvent {
  final Hotel hotel;
  final int index;
  GetHotelItemEvent({required this.hotel,required this.index});
}

class DeleteHotelItemEvent extends EditHotelItemEvent {
  final String hotelId;
  DeleteHotelItemEvent(this.hotelId);
}

