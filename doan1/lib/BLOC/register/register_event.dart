part of 'register_bloc.dart';

@immutable
abstract class abRegisterEvent {}

class RegisterEvent extends abRegisterEvent{
  String? Username, Password, Email, FirstName, LastName, Phone;
  int? Gender;
  RegisterEvent({
    required this.Username,
    required this.Password,
    required this.Email,
    required this.FirstName,
    required this.LastName,
    required this.Phone,
    required this.Gender});
}