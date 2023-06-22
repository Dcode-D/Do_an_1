part of 'create_tour_bloc.dart';

@immutable
abstract class CreateTourState {}

class CreateTourInitial extends CreateTourState {}

class PlanSetState extends CreateTourState {
  bool isPlanSet = false;
  PlanSetState({required this.isPlanSet});
}

class HotelSetState extends CreateTourState {
  bool isHotelSet = false;
  HotelSetState({required this.isHotelSet});
}

class PostTourState extends CreateTourState {
  bool isSuccess = false;
  bool isPosting = false;
  PostTourState({required this.isSuccess, required this.isPosting});
}
