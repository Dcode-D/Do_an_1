import 'dart:async';

import 'package:event_bus_plus/res/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

import '../Preferences.dart';
import '../remote/app_service.dart';
import '../remote/request_factory.dart';
import '../model/remote/login_response.dart';

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
        await _sharedPreferences.setString(Preferences.token, token);
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
      await _sharedPreferences.remove(Preferences.token);
      return true;
    });
  }
}