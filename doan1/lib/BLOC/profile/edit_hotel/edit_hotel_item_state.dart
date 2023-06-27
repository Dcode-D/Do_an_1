part of 'edit_hotel_item_bloc.dart';

@immutable
abstract class EditHotelItemState {}

class EditHotelItemInitial extends EditHotelItemState {}

class EditHotelItemLoaded extends EditHotelItemState {
  bool getDataSuccess;
  bool loading;
  EditHotelItemLoaded(this.getDataSuccess, {this.loading = false});
}

class DeleteHotelItemState extends EditHotelItemState {
  bool deleteSuccess;
  DeleteHotelItemState(this.deleteSuccess);
}

class DeleteHotelRoomState extends EditHotelItemState {
  bool deleteSuccess;
  DeleteHotelRoomState(this.deleteSuccess);
}

class UpdateHotelRoomState extends EditHotelItemState {
  bool updateSuccess;
  UpdateHotelRoomState(this.updateSuccess);
}

class EditHotelResult extends EditHotelItemState {
  bool success;
  EditHotelResult(this.success);
}
