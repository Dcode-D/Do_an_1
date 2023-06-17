import 'package:doan1/data/model/datebooking.dart';
import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Preferences.dart';
import '../remote/app_service.dart';
import '../remote/request_factory.dart';

class DateBookingRepo{
  final EventBus _eventBus;
  final Logger _logger;
  final SharedPreferences _sharedPreferences;
  final AppService _appService;
  final RequestFactory _requestFactory;

  DateBookingRepo(this._logger, this._sharedPreferences, this._appService,
      this._requestFactory, this._eventBus);

  Future<bool> CreateBookingDate(List<String> attachedServices, String startDate, String endDate, String user, String note, bool approved, bool suspended,String type) async
  => _appService.createDateBooking(
        token: "Bearer ${_sharedPreferences.getString(Preferences.token) as String}",
        request: _requestFactory.createBookingDate(
            attachedServices,
            startDate,
            endDate,
            user,
            note,
            approved,
            suspended,
            type))
        .then((http) async {
      if (http.response.statusCode != 200) {
        return false;
      }
      else{
        return true;
      }
    });

  Future<List<DateBooking>?> GetBookingDate(String userId,int page) async
  => _appService.getUserDateBookingList(
          token: "Bearer ${_sharedPreferences.getString(Preferences.token) as String}",
          page: page,
          userId: userId)
        .then((http) async =>
          http.response.statusCode == 200 ?
          http.data.toListDateBooking() : null);

  Future<bool> RejectBookingDate(String dateBookingId) async{
    final response = await _appService.rejectDateBooking(
        token: "Bearer ${_sharedPreferences.getString(Preferences.token) as String}",
        idDateBooking: dateBookingId);
    return response.response.statusCode == 200;
  }

  Future<bool?> DeleteBookingDate(String dateBookingId) async{
    final response = await _appService.deleteDateBooking(
        token: "Bearer ${_sharedPreferences.getString(Preferences.token) as String}",
        idDateBooking: dateBookingId);
    return response.response.statusCode == 200;
  }
}