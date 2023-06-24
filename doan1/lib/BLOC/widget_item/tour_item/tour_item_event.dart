part of 'tour_item_bloc.dart';

@immutable
abstract class TourItemEvent{}

class GetTourItemEvent extends TourItemEvent {
  String? tourId;
  GetTourItemEvent({required this.tourId});
}

class GetTourIsFavorite extends TourItemEvent {}

class LikeTourEvent extends TourItemEvent {
  String? userId;
  LikeTourEvent({required this.userId});
}

class DislikeTourEvent extends TourItemEvent {
}








