part of 'authentication_bloc.dart';
enum authenticateStatus{
  Authorizing,
  Authorized,
  unAuthorized
}

@immutable
abstract class AuthenticationState {}

class AuthenticationInfoState extends AuthenticationState {
  authenticateStatus isloggedin=authenticateStatus.unAuthorized;
  AuthenticationInfoState(
      {authenticateStatus authenStatus=authenticateStatus.unAuthorized})
  {
    this.isloggedin = authenStatus;
  }
}
