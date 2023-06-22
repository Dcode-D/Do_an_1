part of 'edit_tour_bloc.dart';

@immutable
abstract class EditTourState {}

class EditTourInitial extends EditTourState {}

class EditPlanSetState extends EditTourState {
  bool isPlanSet = false;
  EditPlanSetState({required this.isPlanSet});
}

class EditHotelSetState extends EditTourState {
  bool isHotelSet = false;
  EditHotelSetState({required this.isHotelSet});
}

class UpdateTourState extends EditTourState {
  bool isSuccess = false;
  bool isPosting = false;
  UpdateTourState({required this.isSuccess, required this.isPosting});
}