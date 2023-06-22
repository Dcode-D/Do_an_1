part of 'all_tour_bloc.dart';

@immutable
abstract class AllTourEvent {}

class GetTourListEvent extends AllTourEvent{}

class GetTourListExtraEvent extends AllTourEvent{
  final int page;
  GetTourListExtraEvent({
    required this.page,
  });
}

class GetTourByQuery extends AllTourEvent {
  final String query;

  GetTourByQuery(this.query);
}