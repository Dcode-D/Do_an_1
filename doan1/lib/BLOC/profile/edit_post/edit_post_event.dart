part of 'edit_post_bloc.dart';

@immutable
abstract class EditPostEvent {}

class EditPostInitialEvent extends EditPostEvent {
  Article? article;
  EditPostInitialEvent({required this.article});
}