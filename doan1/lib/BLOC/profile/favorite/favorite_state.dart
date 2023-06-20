part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoaded extends FavoriteState{
  final bool? result;
  FavoriteLoaded(this.result);
}