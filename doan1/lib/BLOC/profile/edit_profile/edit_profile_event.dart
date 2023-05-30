part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileEvent{}

class CheckPasswordVisibilityEvent extends EditProfileEvent{}

class CheckPasswordConfirmVisibilityEvent extends EditProfileEvent{}

class CheckInformationEvent extends EditProfileEvent{}

class EditProfileEventSubmit extends EditProfileEvent{
  var updateSuccess = EditProfileStatus.initial;
  String? Username, Address, Email, FirstName, LastName, Phone;
  int? Gender;
  EditProfileEventSubmit({
    required this.Username,
    required this.Address,
    required this.Email,
    required this.FirstName,
    required this.LastName,
    required this.Phone,
    required this.Gender});
}

class EditProfileEventSubmitPassword extends EditProfileEvent{
  var updateSuccess = EditProfileStatus.initial;
  String? Password;
  EditProfileEventSubmitPassword({
    required this.Password});
}

class EditProfileEventgetAvatarFromCamera extends EditProfileEvent{}

class EditProfileEventgetAvatarFromGallery extends EditProfileEvent{}




