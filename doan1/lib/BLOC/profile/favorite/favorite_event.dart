part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class GetListHotelFavoriteEvent extends FavoriteEvent{
  final String? userId;
  final String? type = "hotel";
  GetListHotelFavoriteEvent({required this.userId});
}

class GetListCarFavoriteEvent extends FavoriteEvent{
  final String? userId;
  final String? type = "car";
  GetListCarFavoriteEvent({required this.userId});
}

class GetListTourFavoriteEvent extends FavoriteEvent{
  final String? userId;
  final String? type = "tour";
  GetListTourFavoriteEvent({required this.userId});
}