import 'dart:async';

import 'package:doan1/data/model/user.dart';
import 'package:logger/logger.dart';
import 'package:event_bus_plus/res/event_bus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../remote/app_service.dart';
import '../remote/request_factory.dart';

class UserRepo{
  final EventBus _eventBus;
  final Logger _logger;
  final SharedPreferences _sharedPreferences;
  final AppService _appService;
  final RequestFactory _requestFactory;

  UserRepo(this._logger, this._sharedPreferences, this._appService,
      this._requestFactory, this._eventBus);

  Future<User?> getUser() async {
    return _appService
        .getUser('Bearer '+_sharedPreferences.getString('token')!)
        .then((http) async {
      print(http.response.statusCode);
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toUser();
      }
    });
  }
}