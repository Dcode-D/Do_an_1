part of 'edit_vehicle_item_bloc.dart';

@immutable
abstract class EditVehicleItemState {}

class EditVehicleItemInitial extends EditVehicleItemState {}

class EditVehicleItemLoaded extends EditVehicleItemState {
  bool getDataSuccess;
  bool loading;
  EditVehicleItemLoaded(this.getDataSuccess, this.loading);
}

class EditVehicleItemModified extends EditVehicleItemState {
  bool success;
  EditVehicleItemModified(this.success);
}

class EditVehicleItemDelete extends EditVehicleItemState {
  bool getDataSuccess;
  EditVehicleItemDelete(this.getDataSuccess);
}