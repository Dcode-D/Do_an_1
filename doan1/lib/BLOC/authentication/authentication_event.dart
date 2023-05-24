part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}
class AuthenticateEvent extends AuthenticationEvent{
  String? Username, Password;
  AuthenticateEvent({required this.Username, required this.Password});
}

class LogoutEvent extends AuthenticationEvent{}

class RegisterEvent extends AuthenticationEvent{
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