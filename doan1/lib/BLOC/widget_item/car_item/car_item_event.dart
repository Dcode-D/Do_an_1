part of 'car_item_bloc.dart';

@immutable
abstract class CarItemEvent{}

class GetCarItemEvent extends CarItemEvent{
  String? vehicleId;
  GetCarItemEvent({required this.vehicleId});
}

class GetCarIsFavorite extends CarItemEvent {}

class LikeCarEvent extends CarItemEvent {
  String? userId;
  LikeCarEvent({required this.userId});
}

class DislikeCarEvent extends CarItemEvent {
}