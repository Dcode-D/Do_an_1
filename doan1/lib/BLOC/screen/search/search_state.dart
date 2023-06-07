part of 'search_bloc.dart';

enum SearchStatus { initial, success, failure }

class SearchState{
  SearchStatus? getInitialData = SearchStatus.initial;
  SearchStatus? getCarData = SearchStatus.initial;
  SearchStatus? getHotelData = SearchStatus.initial;
  SearchState({this.getCarData = SearchStatus.initial, this.getHotelData = SearchStatus.initial, this.getInitialData = SearchStatus.initial});
}