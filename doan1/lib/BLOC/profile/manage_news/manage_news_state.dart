part of 'manage_news_bloc.dart';

@immutable
abstract class ManageNewsState {}

class ManageNewsInitial extends ManageNewsState {
  final bool isNewsLoaded;
  ManageNewsInitial({required this.isNewsLoaded});
}