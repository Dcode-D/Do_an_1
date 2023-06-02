part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class GetInitialData extends SearchEvent {}

class GetDataForSearch extends SearchEvent {
  final String brand;
  GetDataForSearch({required this.brand});
}