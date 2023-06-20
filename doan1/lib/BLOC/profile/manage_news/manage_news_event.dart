part of 'manage_news_bloc.dart';

@immutable
abstract class ManageNewsEvent {}

class GetNews extends ManageNewsEvent {
  final String userID;
  GetNews({required this.userID});
}

class LoadMoreNews extends ManageNewsEvent {
  final String userID;
  final int page;
  LoadMoreNews({required this.userID, required this.page});
}

class DeleteNews extends ManageNewsEvent {
  final int articleIndex;
  DeleteNews({required this.articleIndex});
}