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

class CheckInformationEvent extends EditProfileEvent{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CheckInformationEvent({required this.formKey});
}

class EditProfileEventSubmit extends EditProfileEvent{
  bool updateSuccess = false;
  String? Username, Password, Address, Email, FirstName, LastName, Phone;
  int? Gender;
  EditProfileEventSubmit({
    required this.Username,
    required this.Password,
    required this.Address,
    required this.Email,
    required this.FirstName,
    required this.LastName,
    required this.Phone,
    required this.Gender});
}


