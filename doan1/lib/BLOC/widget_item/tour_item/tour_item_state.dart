part of 'tour_item_bloc.dart';

@immutable
abstract class TourItemState{}

class InitialTourItemState extends TourItemState{}

class GetTourItemState extends TourItemState {
  bool getTourItemSuccess;
  GetTourItemState({required this.getTourItemSuccess});
}

class TourItemGetFavoriteState extends TourItemState {
  bool getTourFavoriteSuccess;
  TourItemGetFavoriteState({required this.getTourFavoriteSuccess});
}

class TourItemLoveState extends TourItemState{
  bool loveTourSuccess;
  TourItemLoveState({required this.loveTourSuccess});
}
