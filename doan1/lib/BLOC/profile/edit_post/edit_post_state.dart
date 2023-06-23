part of 'edit_post_bloc.dart';

@immutable
abstract class EditPostState {}

class EditPostInitial extends EditPostState {}

class EditPostDataInitial extends EditPostState {
  bool getDataSuccess = false;
  EditPostDataInitial(this.getDataSuccess);
}

class DeletePostState extends EditPostState {
  bool deleteSuccess = false;
  DeletePostState(this.deleteSuccess);
}

class EditPostResultState extends EditPostState {
  final bool editSuccess;
  EditPostResultState({required this.editSuccess});
}