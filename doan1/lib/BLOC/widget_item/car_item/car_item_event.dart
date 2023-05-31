part of 'car_item_bloc.dart';

@immutable
abstract class CarItemEvent{}

class GetCarItemEvent extends CarItemEvent{
  Vehicle vehicle;
  GetCarItemEvent({required this.vehicle});
}