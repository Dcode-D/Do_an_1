part of 'edit_post_bloc.dart';

@immutable
abstract class EditPostState {}

class EditPostInitial extends EditPostState {}

class EditPostDataInitial extends EditPostState {
  bool getDataSuccess = false;
  EditPostDataInitial(this.getDataSuccess);
}