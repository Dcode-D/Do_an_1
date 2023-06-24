part of 'rating_bloc.dart';

@immutable

abstract class RatingEvent{}

class GetRatingListEvent extends RatingEvent {
  int page;
  String? serviceId;
  String type;
  GetRatingListEvent({required this.page, required this.serviceId,required this.type});
}

class CreateRatingEvent extends RatingEvent {
  String serviceId;
  String userId;
  String content;
  double rating;
  String type;
  CreateRatingEvent({required this.serviceId,required this.userId,required this.content,required this.rating,required this.type});
}

class DeleteRatingEvent extends RatingEvent {
  String ratingId;
  int? index;
  DeleteRatingEvent({required this.ratingId,required this.index});
}

class UpdateRatingEvent extends RatingEvent {
  String ratingId;
  String content;
  double rating;
  UpdateRatingEvent({required this.ratingId,required this.content,required this.rating});
}

