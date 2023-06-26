import 'package:doan1/data/model/tour.dart';
import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../remote/app_service.dart';
import '../remote/request_factory.dart';

class TourRepository {
  final EventBus _eventBus;
  final Logger _logger;
  final SharedPreferences _sharedPreferences;
  final AppService _appService;
  final RequestFactory _requestFactory;

  TourRepository(this._logger, this._sharedPreferences, this._appService,
      this._requestFactory, this._eventBus);

  Future<bool> createTour(String name, String description, double rating, List<String> plans, List<String> hotels, int duration,double price, int maxGroupSize) async{
    final response = await _appService.
    createTour(
        token:"Bearer ${_sharedPreferences.getString("token")!}",
        request:_requestFactory.createPostTour(name, description, rating, plans, hotels, duration, price, maxGroupSize));
    return response.response.statusCode == 200;
  }

  Future<List<Tour>?> getListTourByUser(int page, String userId) async{
    return _appService.getTourList(
        token:"Bearer ${_sharedPreferences.getString("token")!}",
        page: page,
        user: userId,
        city: null,
        province: null,
        referenceName: null,
        ).then((http) async {
      print(http.response.statusCode);
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toListTour();
          }
        }
    );
  }

  Future<bool> deleteTour(String id) async{
    final response = await _appService.deleteTour(
        token:"Bearer ${_sharedPreferences.getString("token")!}",
        id: id,
    );
    return response.response.statusCode == 200;
  }

  Future<List<Tour>?> getListTourByPage(int page) async{
    return _appService.getTourList(
      token:"Bearer ${_sharedPreferences.getString("token")!}",
      page: page,
      user: null,
      city: null,
      province: null,
      referenceName: null,
    ).then((http) async {
      print(http.response.statusCode);
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toListTour();
      }
    }
    );
  }

  Future<List<Tour>?> getListHotelByQuery(int page, String? user, String? city, String? province, String? referenceName) async{
    return _appService.getTourList(
      token:"Bearer ${_sharedPreferences.getString("token")!}",
      page: page,
      user: user,
      city: city,
      province: province,
      referenceName: referenceName,
    ).then((http) async {
      print(http.response.statusCode);
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toListTour();
      }
    }
    );
  }

  Future<Tour?> getTourById(String id) async{
    return _appService.getTourById(
        token:"Bearer ${_sharedPreferences.getString("token")!}",
        id: id,
    ).then((http) async {
      print(http.response.statusCode);
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toTour();
      }
    });
  }

  Future<bool> updateTourInfo(String id, String name, String description, double rating, List<String> plans, int duration,double price, int maxGroupSize) async{
    final response = await _appService.updateTour(
        token:"Bearer ${_sharedPreferences.getString("token")!}",
        id: id,
        request:_requestFactory.updateTourInfo(name, description, rating, plans, duration, price, maxGroupSize));
    return response.response.statusCode == 200;
  }
}