part of 'edit_vehicle_item_bloc.dart';

@immutable
abstract class EditVehicleItemState {}

class EditVehicleItemInitial extends EditVehicleItemState {}

class EditVehicleItemLoaded extends EditVehicleItemState {
  bool getDataSuccess;
  EditVehicleItemLoaded(this.getDataSuccess);
}

class EditVehicleItemDelete extends EditVehicleItemState {
  bool getDataSuccess;
  EditVehicleItemDelete(this.getDataSuccess);
}