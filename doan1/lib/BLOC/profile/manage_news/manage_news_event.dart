part of 'manage_news_bloc.dart';

@immutable
abstract class ManageNewsEvent {}

class GetNews extends ManageNewsEvent {
  final String userID;
  GetNews({required this.userID});
}