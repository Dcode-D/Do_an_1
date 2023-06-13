part of 'create_tour_bloc.dart';

@immutable
abstract class CreateTourEvent {}

class SetTourPlan extends CreateTourEvent{
  List<Article> tourPlan;
  SetTourPlan({required this.tourPlan});
}

class RemoveTourPlan extends CreateTourEvent{
  int index;
  RemoveTourPlan({required this.index});
}

