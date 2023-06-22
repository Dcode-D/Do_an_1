part of 'create_tour_bloc.dart';
enum ImagePickMethod {gallery, camera}
@immutable
abstract class CreateTourEvent {}

class SetTourPlan extends CreateTourEvent{
  List<Article> tourPlan;
  SetTourPlan({required this.tourPlan});
}

class RemoveTourPlan extends CreateTourEvent{
  Article article;
  RemoveTourPlan({required this.article});
}

class SetHotelPlan extends CreateTourEvent{
  List<Hotel> tourHotel;
  SetHotelPlan({required this.tourHotel});
}

class RemoveHotelPlan extends CreateTourEvent{
  Hotel hotel;
  RemoveHotelPlan({required this.hotel});
}

class PostTour extends CreateTourEvent{
  final String name;
  final String description;
  final double rating;
  final int duration;
  final double price;
  final int maxGroupSize;
  PostTour({required this.name, required this.description, required this.rating, required this.duration, required this.price, required this.maxGroupSize});
}


