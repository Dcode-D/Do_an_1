part of 'all_hotel_bloc.dart';

@immutable
abstract class AllHotelEvent {}

class GetHotelListEvent extends AllHotelEvent{}

class GetHotelListExtraEvent extends AllHotelEvent{
  final int page;
  GetHotelListExtraEvent({
    required this.page,
  });
}

class GetHotelByQuery extends AllHotelEvent {
  final String query;

  GetHotelByQuery(this.query);
}