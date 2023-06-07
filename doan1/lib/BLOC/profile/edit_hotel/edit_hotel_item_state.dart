part of 'edit_hotel_item_bloc.dart';

@immutable
abstract class EditHotelItemState {}

class EditHotelItemInitial extends EditHotelItemState {}

class EditHotelItemLoaded extends EditHotelItemState {
  bool getDataSuccess;
  EditHotelItemLoaded(this.getDataSuccess);
}