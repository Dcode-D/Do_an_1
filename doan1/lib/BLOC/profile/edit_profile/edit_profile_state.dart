part of 'edit_profile_bloc.dart';

enum EditProfileStatus { initial, success, failure }

@immutable
abstract class EditProfileState{
}

class EditProfileInfoState extends EditProfileState {
  bool isPassWordVisible = false;
  bool isPassWordConfirmVisible = false;
  EditProfileStatus updateSuccess = EditProfileStatus.initial;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
    EditProfileInfoState({
    bool isPassWordVisible = false,
    bool isPassWordConfirmVisible = false,
    EditProfileStatus updateSuccess = EditProfileStatus.initial,
    required GlobalKey<FormState> formKey
    })
  {
    this.isPassWordVisible = isPassWordVisible;
    this.isPassWordConfirmVisible = isPassWordConfirmVisible;
    this.updateSuccess = updateSuccess;
    this.formKey = formKey;
  }
}
