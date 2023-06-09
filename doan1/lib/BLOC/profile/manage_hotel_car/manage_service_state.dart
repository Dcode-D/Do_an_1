part of 'manage_service_bloc.dart';

@immutable
abstract class ManageServiceState{
}

class ManageServiceInitial extends ManageServiceState{}

class GetInitialDataState extends ManageServiceState{
  bool? getDataSuccess;
  GetInitialDataState(this.getDataSuccess);
}

class LoadMoreVehicleDataState extends ManageServiceState{
  bool? getDataSuccess;
  LoadMoreVehicleDataState(this.getDataSuccess);
}

class LoadMoreHotelDataState extends ManageServiceState{
  bool? getDataSuccess;
  LoadMoreHotelDataState(this.getDataSuccess);
}