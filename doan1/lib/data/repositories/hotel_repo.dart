import 'dart:io';

import 'package:doan1/data/model/hotel.dart';
import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Preferences.dart';
import '../remote/app_service.dart';
import '../remote/request_factory.dart';

class HotelRepo{
  final EventBus _eventBus;
  final Logger _logger;
  final SharedPreferences _sharedPreferences;
  final AppService _appService;
  final RequestFactory _requestFactory;

  HotelRepo(this._logger, this._sharedPreferences, this._appService,
      this._requestFactory, this._eventBus);

  Future<List<Hotel>?> getListHotelByName(String name,int page) async{
    return _appService
        .getListHotelByQuery(page,null,name,null,null,null,null,null,null)
        .then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toListHotel();
      }
    });
  }

  Future<List<Hotel>?> getListHotelByOwner(String owner,int page) async{
    return _appService
        .getListHotelByQuery(page,owner,null,null,null,null,null,null,null)
        .then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toListHotel();
      }
    });
  }

  Future<List<Hotel>?> getListHotel(int page) async {
    return _appService
        .getListHotelFromPage(page)
        .then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toListHotel();
      }
    });
  }

  Future<bool> createHotel(String name, String description, String address, String province, String district, List<File> files) async{
    return _appService
        .createHotel(token:"Bearer ${_sharedPreferences.getString(Preferences.token) as String}", name: name, description: description, address: address, province: province, district: district, files: files)
        .then((http) async {
      if (http.response.statusCode != 200) {
        return false;
      }
      else{
        return true;
      }
    });
  }
}