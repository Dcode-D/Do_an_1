part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class GetInitialData extends SearchEvent {}

class GetHotelForSearch extends SearchEvent {
  final String searchText;
  GetHotelForSearch({required this.searchText});
}

class GetVehicleForSearch extends SearchEvent {
  final String searchText;
  GetVehicleForSearch({required this.searchText});
}

class GetTourForSearch extends SearchEvent {
  final String searchText;
  GetTourForSearch({required this.searchText});
}