import 'package:doan1/data/model/hotel.dart';
import 'package:event_bus_plus/res/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<int?> getMaxPage() async {
    return _appService
        .getHotelMaxPage()
        .then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data;
      }
    });
  }

  Future<List<Hotel>?> getListHotelByName(String name) async{
    return _appService
        .getListHotelByName(name)
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
}