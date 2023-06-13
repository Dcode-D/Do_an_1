part of 'create_tour_bloc.dart';

@immutable
abstract class CreateTourState {}

class CreateTourInitial extends CreateTourState {}

class PlanSetState extends CreateTourState {
  bool isPlanSet = false;
  PlanSetState({required this.isPlanSet});
}
