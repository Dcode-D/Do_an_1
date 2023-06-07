part of 'manage_service_bloc.dart';

@immutable
abstract class ManageServiceEvent{}

class GetDataByOwner extends ManageServiceEvent{
  final String owner;
  GetDataByOwner(this.owner);
}