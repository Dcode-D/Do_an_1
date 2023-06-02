part of 'search_bloc.dart';

enum SearchStatus { initial, success, failure }

class SearchState{
  SearchStatus? getInitialData = SearchStatus.initial;
  SearchStatus getData = SearchStatus.initial;
  SearchState({this.getData = SearchStatus.initial,this.getInitialData = SearchStatus.initial});
}