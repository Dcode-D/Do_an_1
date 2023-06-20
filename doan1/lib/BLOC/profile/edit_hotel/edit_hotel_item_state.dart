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

class EditHotelResult extends EditHotelItemState {
  bool success;
  EditHotelResult(this.success);
}
