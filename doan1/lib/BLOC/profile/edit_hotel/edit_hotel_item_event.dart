part of 'edit_hotel_item_bloc.dart';

@immutable
abstract class EditHotelItemEvent {}

class GetHotelItemEvent extends EditHotelItemEvent {
  final Hotel hotel;
  GetHotelItemEvent(this.hotel);
}

