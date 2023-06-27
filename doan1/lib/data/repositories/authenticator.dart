import 'dart:async';

import 'package:doan1/EventBus/Events/Authenevent.dart';
import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

import '../Preferences.dart';
import '../model/response.dart';
import '../remote/app_service.dart';
import '../remote/request_factory.dart';

class Authenticator {
  final EventBus _eventBus;
  final Lock _refreshTaskLock = Lock();
  final Logger _logger;
  final SharedPreferences _sharedPreferences;
  final AppService _appService;
  final RequestFactory _requestFactory;
  Timer? _refreshTask;

  Authenticator(this._logger, this._sharedPreferences, this._appService,
      this._requestFactory, this._eventBus);


  Future<bool> login(String username, String password) async {
    return _appService
        .login(_requestFactory.createLogin(username, password))
        .then((http) async {
      print(http.response.statusCode);
      if (http.response.statusCode != 200) {
        return false;
      }
      bool isSuccess = false;

      isSuccess = http.data.token.isNotEmpty;

      if (isSuccess) {
        var token = http.data.token;
        await _sharedPreferences.remove(Preferences.token);
        await _sharedPreferences.setString(Preferences.token, token);
        _eventBus.fire(EBAuthenEvent(true));
        _logger.i("New token received: $token");
      }
      return isSuccess;
    });
  }

  Future<bool> logout() async {
    return _appService.logout('Bearer '+_sharedPreferences.getString(Preferences.token)!).then((http) async {
      if (http.response.statusCode != 200) {
        return false;
      }
      _eventBus.fire(EBAuthenEvent(false));
      await _sharedPreferences.remove(Preferences.token);
      return true;
    });
  }

  Future<Response> register(String username, String password, String email, String firstname, String lastname,String phone, String address,int gender) async {
    return _appService
        .register(_requestFactory.createRegister(username, password, email, firstname, lastname, phone, address, gender))
        .then((http) async {
         if (http.response.statusCode != 200) {
           return Response(status: http.response.statusCode.toString(),message: http.response.statusMessage!);
         }
         else{
           return Response(status: http.response.statusCode.toString(),message: http.response.statusMessage!);
         }
    });
  }
}