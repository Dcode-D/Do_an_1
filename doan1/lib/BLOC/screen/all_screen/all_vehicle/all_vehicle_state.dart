part of 'all_vehicle_bloc.dart';

class AllVehicleState {
  bool? getListVehicleSuccess;
  bool? getExtraListVehicleSuccess;
  bool? maxData;
  bool isLoadingMore = false;
  AllVehicleState({this.getListVehicleSuccess,this.getExtraListVehicleSuccess,this.maxData,required this.isLoadingMore});
}