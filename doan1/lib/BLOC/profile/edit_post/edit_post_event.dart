part of 'edit_post_bloc.dart';

@immutable
abstract class EditPostEvent {}

class EditPostInitialEvent extends EditPostEvent {
  Article? article;
  EditPostInitialEvent({required this.article});
}

class DeletePostEvent extends EditPostEvent {
  final String articleID;
  DeletePostEvent({required this.articleID});
}

class RefreshPostEvent extends EditPostEvent {
  RefreshPostEvent();
}

class EditPostEventDeleteImage extends EditPostEvent {
  final int index;
  EditPostEventDeleteImage({required this.index});
}

class EditPostEventAddImage extends EditPostEvent {
  final ImagePickMethod method;
  EditPostEventAddImage({required this.method});
}

class EditPostEventUpdate extends EditPostEvent {
  final String title;
  final String name;
  final String address;
  final String description;
  EditPostEventUpdate({required this.title, required this.name, required this.address, required this.description});
}