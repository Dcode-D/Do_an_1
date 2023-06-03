part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class GetInitialData extends SearchEvent {}

class GetDataForSearch extends SearchEvent {
  final String searchText;
  GetDataForSearch({required this.searchText});
}