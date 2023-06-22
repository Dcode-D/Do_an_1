part of 'edit_tour_bloc.dart';

@immutable
abstract class EditTourEvent {}

class SetEditTourPlan extends EditTourEvent{
  List<Article> tourPlan;
  SetEditTourPlan({required this.tourPlan});
}

class RemoveEditTourPlan extends EditTourEvent{
  Article article;
  RemoveEditTourPlan({required this.article});
}

class UpdateTourEvent extends EditTourEvent{
  final String id;
  final String name;
  final String description;
  final double rating;
  final int duration;
  final double price;
  final int maxGroupSize;
  UpdateTourEvent({required this.id, required this.name, required this.description, required this.rating, required this.duration, required this.price, required this.maxGroupSize});
}
