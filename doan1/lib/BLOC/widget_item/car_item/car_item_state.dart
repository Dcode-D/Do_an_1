part of 'car_item_bloc.dart';

@immutable
abstract class CarItemState{}

class InitialCarItemState extends CarItemState{}

class CarItemGetState extends CarItemState{
  bool getCarItemSuccess;
  CarItemGetState({required this.getCarItemSuccess});
}

class CarItemGetFavoriteState extends CarItemState{
  bool getCarFavoriteSuccess;
  CarItemGetFavoriteState({required this.getCarFavoriteSuccess});
}

class CarItemLoveState extends CarItemState{
  bool loveCarSuccess;
  CarItemLoveState({required this.loveCarSuccess});
}