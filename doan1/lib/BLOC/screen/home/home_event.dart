part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetUserForScreenEvent extends HomeEvent {}

class GetVehicleForScreenEvent extends HomeEvent {}