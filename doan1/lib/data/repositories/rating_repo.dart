import 'package:doan1/data/model/rating.dart';
import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../remote/app_service.dart';
import '../remote/request_factory.dart';

class RatingRepository{
  final EventBus _eventBus;
  final Logger _logger;
  final SharedPreferences _sharedPreferences;
  final AppService _appService;
  final RequestFactory _requestFactory;

  RatingRepository(this._logger, this._sharedPreferences, this._appService,
      this._requestFactory, this._eventBus);

  Future<bool> createRating(String userId,String serviceId, double rating, String comment, String type) async {
    return _appService.createRating(
        token: 'Bearer ${_sharedPreferences.getString('token')!}',
        request: _requestFactory.createRating(userId, serviceId, rating, comment, type)
    ).then((http)async{
      if(http.response.statusCode != 200){
        return false;
      }
      else{
        return true;
      }
    });
  }

  Future<bool> updateRating(String id, double rating, String comment) async {
    return _appService.updateRating(
        token: 'Bearer ${_sharedPreferences.getString('token')!}',
        id: id,
        request: _requestFactory.updateRating(rating, comment)
    ).then((http)async{
      if(http.response.statusCode != 200){
        return false;
      }
      else{
        return true;
      }
    });
  }

  Future<bool> deleteRating(String id) async {
    return _appService.deleteRating(
        token: 'Bearer ${_sharedPreferences.getString('token')!}',
        id: id
    ).then((http)async{
      if(http.response.statusCode != 200){
        return false;
      }
      else{
        return true;
      }
    });
  }

  Future<double?> getGeneralRating(String type ,String serviceId) async {
    return _appService.getGeneralRating(
        type: type,
        service: serviceId
    ).then((http)async{
      if(http.response.statusCode != 200){
        return null;
      }
      else{
        return http.data.toRatingPoint();
      }
    });
  }

  Future<List<Rating>?> getListRating(int page,String? service, String? user, double? rating) async {
    return _appService.getRatingList(page: page,
        service: service,
        user: user,
        rating: rating
    ).then((http)async{
      if(http.response.statusCode != 200){
        return null;
      }
      else{
        return http.data.toListRating();
      }
    });
  }

}