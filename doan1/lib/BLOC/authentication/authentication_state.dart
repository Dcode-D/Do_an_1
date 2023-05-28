part of 'authentication_bloc.dart';
enum authenticateStatus{
  Authorizing,
  Authorized,
  unAuthorized,
  Activate,
}

@immutable
abstract class AuthenticationState {}

class AuthenticationInfoState extends AuthenticationState {
  authenticateStatus isloggedin=authenticateStatus.Activate;
  AuthenticationInfoState
      ({authenticateStatus authenStatus=authenticateStatus.Activate})
  {
    this.isloggedin = authenStatus;
  }
}
