part of 'tour_item_bloc.dart';

@immutable
abstract class TourItemState{}

class InitialTourItemState extends TourItemState{}

class GetTourItemState extends TourItemState {
  bool getTourItemSuccess;
  GetTourItemState({required this.getTourItemSuccess});
}

class TourItemGetFavoriteState extends TourItemState {
  bool getHotelFavoriteSuccess;
  TourItemGetFavoriteState({required this.getHotelFavoriteSuccess});
}

class TourItemLoveState extends TourItemState{
  bool loveHotelSuccess;
  TourItemLoveState({required this.loveHotelSuccess});
}