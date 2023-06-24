part of 'rating_item_bloc.dart';

@immutable
abstract class RatingItemState {}

class RatingItemInitialState extends RatingItemState {}

class GetRatingItemState extends RatingItemState {
  bool getRatingItemSuccess;
  GetRatingItemState({required this.getRatingItemSuccess});
}