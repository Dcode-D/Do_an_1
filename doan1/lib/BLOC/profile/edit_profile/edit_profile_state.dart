part of 'edit_profile_bloc.dart';

enum EditProfileStatus { initial, success, failure }

@immutable
abstract class EditProfileState{
}

class EditProfileInfoState extends EditProfileState {
  bool isPassWordVisible = false;
  bool isPassWordConfirmVisible = false;
  EditProfileStatus updateSuccess = EditProfileStatus.initial;
  EditProfileStatus getImageSuccess = EditProfileStatus.initial;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
    EditProfileInfoState({
    bool isPassWordVisible = false,
    bool isPassWordConfirmVisible = false,
    EditProfileStatus getImageSuccess = EditProfileStatus.initial,
    EditProfileStatus updateSuccess = EditProfileStatus.initial,
    required GlobalKey<FormState> formKey
    })
  {
    this.isPassWordVisible = isPassWordVisible;
    this.isPassWordConfirmVisible = isPassWordConfirmVisible;
    this.updateSuccess = updateSuccess;
    this.getImageSuccess = getImageSuccess;
    this.formKey = formKey;
  }
}
