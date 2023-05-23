
import 'package:bloc/bloc.dart';
import 'package:doan1/dependency.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/authenticator.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationInfoState> {
  AuthenticationBloc() : super(AuthenticationInfoState()) {
    on<AuthenticateEvent>((event, emit) async {
      var authenticator = GetIt.instance.get<Authenticator>();
      bool loginstate = await authenticator.login(
          event.Username as String, event.Password as String);
      emit(AuthenticationInfoState(authenStatus: authenticateStatus.Authorizing));
      if(loginstate) {
        print("Login success");
        emit(AuthenticationInfoState(authenStatus: authenticateStatus.Authorized));
      }
      else
      {
        print("Log in failed");
        emit(AuthenticationInfoState(
            authenStatus: authenticateStatus.unAuthorized));
        // timer!.cancel();
      }
    });
    on<LogoutEvent>((event, emit) async {
      var authenticator = GetIt.instance.get<Authenticator>();
      bool logoutstate = await authenticator.logout();
      if(logoutstate) {
        print("Logout success");
        emit(AuthenticationInfoState(authenStatus: authenticateStatus.unAuthorized));
      }
      else
      {
        print("Log out failed");
        emit(AuthenticationInfoState(
            authenStatus: authenticateStatus.Authorized));
        // timer!.cancel();
      }
    });

  }
}
