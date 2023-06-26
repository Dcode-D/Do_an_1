part of 'edit_tour_bloc.dart';

@immutable
abstract class EditTourEvent {}

class EditTourInitialEvent extends EditTourEvent {
  String? tourId;
  EditTourInitialEvent({required this.tourId});
}

class DeleteTourEvent extends EditTourEvent {
  final String tourID;
  DeleteTourEvent({required this.tourID});
}

class SetEditTourPlan extends EditTourEvent{
  List<Article> tourPlan;
  SetEditTourPlan({required this.tourPlan});
}

class RemoveEditTourPlan extends EditTourEvent{
  Article article;
  RemoveEditTourPlan({required this.article});
}

class SetEditHotelPlan extends EditTourEvent{
  List<Hotel> tourHotel;
  SetEditHotelPlan({required this.tourHotel});
}

class RemoveEditHotelPlan extends EditTourEvent{
  Hotel hotel;
  RemoveEditHotelPlan({required this.hotel});
}

class UpdateTourEvent extends EditTourEvent{
  final String name;
  final String description;
  final double rating;
  final int duration;
  final double price;
  final int maxGroupSize;
  UpdateTourEvent({required this.name, required this.description, required this.rating, required this.duration, required this.price, required this.maxGroupSize});
}

class RefreshTourInfo extends EditTourEvent{}

