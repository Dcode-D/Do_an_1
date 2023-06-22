import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doan1/data/model/user.dart';
import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:retrofit/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../remote/app_service.dart';
import '../remote/request_factory.dart';

class UserRepository{
  final EventBus _eventBus;
  final Logger _logger;
  final SharedPreferences _sharedPreferences;
  final AppService _appService;
  final RequestFactory _requestFactory;

  UserRepository(this._logger, this._sharedPreferences, this._appService,
      this._requestFactory, this._eventBus);

  Future<User?> getUser() async {
    return _appService
        .getUser('Bearer ${_sharedPreferences.getString('token')!}')
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

  Future<User?> getUserById(String id)async{
    return _appService
        .getUserById(id)
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

  Future<bool> updateUser(String username, String email, String firstname, String lastname,String phone, String address,int gender) async {
    return _appService
        .updateUser(
        'Bearer ${_sharedPreferences.getString('token')!}'
          ,_requestFactory.updateUser(username, email, firstname, lastname, phone, address, gender))
        .then((http) async {
      print(http.response.statusCode);
      if (http.response.statusCode != 200) {
        return false;
      }
      else{
        return true;
      }
    });
  }

  Future<bool> changePassWord(String password) async {
    return _appService
        .updateUser(
        'Bearer ${_sharedPreferences.getString('token')!}'
          ,_requestFactory.updateUserPassWord(password))
        .then((http) async {
      print(http.response.statusCode);
      if (http.response.statusCode != 200) {
        return false;
      }
      else{
        return true;
      }
    });
  }

  Future<List<String>?> getListAvatarId(String id) async {
    return _appService
        .getListAvatarId(id)
        .then((http) async {
      print(http.response.statusCode);
      if (http.response.statusCode != 200) {
        return [];
      }
      else{
        return http.data.data;
      }
    });
  }

  Future<bool> updateAvatar(File file) async {
    return _appService
        .updateAvatar(
        'Bearer ${_sharedPreferences.getString('token')!}'
          ,file)
        .then((http) async {
      print(http.response.statusCode);
      if (http.response.statusCode != 200) {
        return false;
      }
      else{
        return true;
      }
    });
  }
}