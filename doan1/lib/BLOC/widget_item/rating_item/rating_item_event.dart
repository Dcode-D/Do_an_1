part of 'rating_item_bloc.dart';

@immutable
abstract class RatingItemEvent {}

class GetRatingItemEvent extends RatingItemEvent {
  Rating rating;
  GetRatingItemEvent({required this.rating});
}