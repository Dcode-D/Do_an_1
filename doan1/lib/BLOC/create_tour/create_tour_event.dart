part of 'create_tour_bloc.dart';

@immutable
abstract class CreateTourEvent {}

class SetTourPlan extends CreateTourEvent{
  List<Article> tourPlan;
  SetTourPlan({required this.tourPlan});
}

