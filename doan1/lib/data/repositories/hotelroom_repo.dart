import 'package:doan1/data/model/hotelroom.dart';
import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../remote/app_service.dart';
import '../remote/request_factory.dart';

class HotelRoomRepository{
  final EventBus _eventBus;
  final Logger _logger;
  final SharedPreferences _sharedPreferences;
  final AppService _appService;
  final RequestFactory _requestFactory;

  HotelRoomRepository(this._logger, this._sharedPreferences, this._appService,
      this._requestFactory, this._eventBus);

  Future<List<HotelRoom>?> getHotelRoomListWithDate(String hotelId,String startDate,String endDate) async {
    return _appService
        .getListHotelRoomByIdWithDate(hotelId,startDate,endDate)
        .then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toListHotelRoom();
      }
    });
  }

  Future<List<HotelRoom>?> getHotelRoomList(String hotelId) async {
    return _appService
        .getListHotelRoomById(hotelId)
        .then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toListHotelRoom();
      }
    });
  }

  Future<HotelRoom?> getHotelRoomById(String hotelRoomId) async {
    return _appService
        .getHotelRoomById(hotelRoomId)
        .then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toHotelRoom();
      }
    });
  }

  Future<bool> createHotelRoom(List<HotelRoom> hotelRooms, String hotelid) async {
    return _appService
        .createRooms(
      token: "Bearer ${_sharedPreferences.getString("token")}",
      hotel: hotelid,
      request: _requestFactory.createRooms(hotelRooms),
    )
        .then((http) async {
      if (http.response.statusCode != 200) {
        return false;
      }
      else{
        return true;
      }
    });
  }

  Future<bool> updateHotelRoom(String id, String room, HotelRoom hotelRoom) async {
    return _appService
        .updateHotelRoomById(
      token: "Bearer ${_sharedPreferences.getString("token")}",
      id: id,
      room: room,
      request: _requestFactory.updateRoom(hotelRoom),
    )
        .then((http) async {
      if (http.response.statusCode != 200) {
        return false;
      }
      else{
        return true;
      }
    });
  }

  Future<bool> deleteHotelRoom(String id,String room) async {
    return _appService
        .deleteHotelRoomById(
      token: "Bearer ${_sharedPreferences.getString("token")}",
      id: id,
      room: room,
    )
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