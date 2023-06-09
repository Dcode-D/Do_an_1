part of 'manage_service_bloc.dart';

@immutable
abstract class ManageServiceEvent{}

class GetDataByOwner extends ManageServiceEvent{
  final String owner;
  final int page;
  GetDataByOwner(this.owner,this.page);
}

class LoadMoreVehicleData extends ManageServiceEvent{
  final String owner;
  final int page;
  LoadMoreVehicleData(this.owner,this.page);
}

class LoadMoreHotelData extends ManageServiceEvent{
  final String owner;
  final int page;
  LoadMoreHotelData(this.owner,this.page);
}