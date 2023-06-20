part of 'edit_post_bloc.dart';

@immutable
abstract class EditPostEvent {}

class EditPostInitialEvent extends EditPostEvent {
  Article? article;
  int? index;
  EditPostInitialEvent({required this.article,required this.index});
}

class DeletePostEvent extends EditPostEvent {
  final String articleID;
  DeletePostEvent({required this.articleID});
}