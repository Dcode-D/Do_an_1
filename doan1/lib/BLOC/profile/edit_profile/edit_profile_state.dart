part of 'edit_profile_bloc.dart';

class EditProfileState{
  bool isPassWordVisible = false;
  bool isPassWordConfirmVisible = false;
  bool updateSuccess = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  EditProfileState({required this.isPassWordVisible, required this.isPassWordConfirmVisible, required this.formKey, required this.updateSuccess});
}