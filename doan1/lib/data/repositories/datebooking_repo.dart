import 'package:doan1/EventBus/Events/NeedRefreshBookHistoryEvent.dart';
import 'package:doan1/data/model/datebooking.dart';
import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Preferences.dart';
import '../remote/app_service.dart';
import '../remote/request_factory.dart';

class DateBookingRepository{
  final EventBus _eventBus;
  final Logger _logger;
  final SharedPreferences _sharedPreferences;
  final AppService _appService;
  final RequestFactory _requestFactory;

  DateBookingRepository(this._logger, this._sharedPreferences, this._appService,
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

  Future<List<DateBooking>?> GetBookingDate(String userId,int page, String type) async
  => _appService.getUserDateBookingList(
          token: "Bearer ${_sharedPreferences.getString(Preferences.token) as String}",
          page: page,
          userId: userId,
          type: type)
        .then((http) async =>
          http.response.statusCode == 200 ?
          http.data.toListDateBooking() : null);

  Future<bool> RejectBookingDate(String dateBookingId) async{
    final response = await _appService.rejectDateBooking(
        token: "Bearer ${_sharedPreferences.getString(Preferences.token) as String}",
        idDateBooking: dateBookingId);
    _eventBus.fire(NeedRefreshBookHistoryEvent());
    return response.response.statusCode == 200;
  }

  Future<bool?> DeleteBookingDate(String dateBookingId) async{
    final response = await _appService.deleteDateBooking(
        token: "Bearer ${_sharedPreferences.getString(Preferences.token) as String}",
        idDateBooking: dateBookingId);
    _eventBus.fire(NeedRefreshBookHistoryEvent());
    return response.response.statusCode == 200;
  }

  Future<bool?> ApproveBookingDate(String dateBookingId) async{
    final response = await _appService.approveDateBooking(
        token: "Bearer ${_sharedPreferences.getString(Preferences.token) as String}",
        idDateBooking: dateBookingId);
    _eventBus.fire(NeedRefreshBookHistoryEvent());
    return response.response.statusCode == 200;
  }

  Future<List<DateBooking>?> GetHotelBookingByHotelId(String hotelId, int page) async{
    final response = await _appService.getHotelDateBookingList(
        token: "Bearer ${_sharedPreferences.getString(Preferences.token) as String}",
        idHotel: hotelId,
        page: page);
    return response.response.statusCode == 200 ?
    response.data.toListDateBooking() : null;
  }

  Future<List<DateBooking>?> GetVehicleBookingByVehicleId(String vehicleId, int page) async{
    final response = await _appService.getCarDateBookingList(
        token: "Bearer ${_sharedPreferences.getString(Preferences.token) as String}",
        idCar: vehicleId,
        page: page);
    return response.response.statusCode == 200 ?
    response.data.toListDateBooking() : null;
  }

  Future<DateBooking?> GetDateBookingById(String id) async {
    final response = await _appService.getDateBookingById(
        token: "Bearer ${_sharedPreferences.getString(Preferences.token) as String}",
        idDateBooking: id);
    return response.response.statusCode == 200 ?
    response.data.toDateBooking() : null;
  }
}