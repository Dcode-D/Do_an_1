part of 'all_vehicle_bloc.dart';

@immutable
abstract class AllVehicleEvent {}

class GetVehicleListEvent extends AllVehicleEvent{}

class GetVehicleListExtraEvent extends AllVehicleEvent{
  final int page;
  GetVehicleListExtraEvent({
    required this.page,
  });
}