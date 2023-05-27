part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileEvent{}

class CheckPasswordVisibilityEvent extends EditProfileEvent{
  bool isPassWordVisible = true;
  CheckPasswordVisibilityEvent({required this.isPassWordVisible});
}

class CheckPasswordConfirmVisibilityEvent extends EditProfileEvent{
  bool isPassWordConfirmVisible = true;
  CheckPasswordConfirmVisibilityEvent({required this.isPassWordConfirmVisible});
}

class getProfileEvent extends EditProfileEvent{
}


