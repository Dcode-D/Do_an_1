
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationInfoState> {
  AuthenticationBloc() : super(AuthenticationInfoState()) {
    on<AuthenticateEvent>((event, emit) async {
      emit(AuthenticationInfoState(authenStatus: authenticateStatus.Authorizing));
      if(true) {
        print("Login success");
        emit(AuthenticationInfoState(authenStatus: authenticateStatus.Authorized));
      }
      else {
        print("Log in failed");
        emit(AuthenticationInfoState(
            authenStatus: authenticateStatus.unAuthorized));
        // timer!.cancel();
      }
    });
  }
}
