
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doan1/dependency.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../EventBus/Events/Authenevent.dart';
import '../../data/repositories/authenticator.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationInfoState> {
  AuthenticationBloc() : super(AuthenticationInfoState()) {
    on<AuthenticateEvent>((event, emit) async {
      var authenticator = GetIt.instance.get<Authenticator>();
      try
      {
        bool loginstate = await authenticator.login(
            event.Username as String, event.Password as String);
        emit(AuthenticationInfoState(authenStatus: authenticateStatus.Authorizing));
        if(loginstate) {
          print("Login success");
          emit(AuthenticationInfoState(authenStatus: authenticateStatus.Authorized));
          FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
          final permission = await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!.requestPermission();
        }
      }
      catch(e)
      {
        if(e is DioError){
          print(e.response!.data);
        }
        print("Log in failed");
        emit(AuthenticationInfoState(authenStatus: authenticateStatus.unAuthorized));
      }
    });
    on<LogoutEvent>((event, emit) async {
      var authenticator = GetIt.instance.get<Authenticator>();

      try{
        bool logoutstate = await authenticator.logout();
        if(logoutstate) {
          print("Logout success");
          emit(AuthenticationInfoState(authenStatus: authenticateStatus.Activate));
        }
      }
      catch(e){
        if(e is DioError){
          print(e.response!.data);
        }
        print("Log out failed");
        emit(AuthenticationInfoState(
            authenStatus: authenticateStatus.Authorized));
      }
    });
  }
}
