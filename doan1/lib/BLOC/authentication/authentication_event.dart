part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}
class AuthenticateEvent extends AuthenticationEvent{
  String? Username, Password;
  AuthenticateEvent({required this.Username, required this.Password});
}

class LogoutEvent extends AuthenticationEvent{}

class RegisterEvent extends AuthenticationEvent{
  String? Username, Password;
  RegisterEvent({required this.Username, required this.Password});
}