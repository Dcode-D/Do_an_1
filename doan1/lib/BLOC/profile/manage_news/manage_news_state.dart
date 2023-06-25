part of 'manage_news_bloc.dart';

@immutable
abstract class ManageNewsState {}

class ManageNewsInitial extends ManageNewsState {
}

class GetNewsInitialState extends ManageNewsState {
  final bool isNewsLoaded;
  GetNewsInitialState({required this.isNewsLoaded});
}

class LoadMoreNewsState extends ManageNewsState {
  final bool isNewsLoaded;
  LoadMoreNewsState({required this.isNewsLoaded});
}

class DeleteNewsState extends ManageNewsState {
  final bool isDeleted;
  DeleteNewsState({required this.isDeleted});
}

class LoadMoreTourState extends ManageNewsState {
  final bool isTourLoaded;
  LoadMoreTourState({required this.isTourLoaded});
}

class DeleteTourState extends ManageNewsState {
  final bool isDeleted;
  DeleteTourState({required this.isDeleted});
}
