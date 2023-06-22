import 'package:doan1/data/model/favorite.dart';
import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../remote/app_service.dart';
import '../remote/request_factory.dart';

class FavoriteRepository {
  final EventBus _eventBus;
  final Logger _logger;
  final SharedPreferences _sharedPreferences;
  final AppService _appService;
  final RequestFactory _requestFactory;

  FavoriteRepository(this._logger, this._sharedPreferences, this._appService,
      this._requestFactory, this._eventBus);

  Future<List<String>?> getListFavoriteIdByUserId(String type,String userId) async {
    return _appService
        .getFavoriteByUser(
      token: 'Bearer ${_sharedPreferences.getString('token')!}',
      type: type, )
        .then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toListIdFavorite();
      }
    });
  }

  Future<Favorite?> getFavoriteById(String id) async{
    return _appService.getFavoriteById(
        token: 'Bearer ${_sharedPreferences.getString('token')!}',
        id: id
    ).then((http)async{
      if(http.response.statusCode != 200){
        return null;
      }
      else{
        return http.data.toFavorite();
      }
    });
  }

  Future<bool> createFavorite(String type,String userId,String productId) async{
    return _appService.createFavorite(
        token: 'Bearer ${_sharedPreferences.getString('token')!}',
        type: type,
        request: _requestFactory.createFavorite(userId, productId, type)
    ).then((http)async{
      if(http.response.statusCode != 200){
        return false;
      }
      else{
        return true;
      }
    });
  }

  Future<bool> deleteFavorite(String id) async{
    return _appService.deleteFavoriteById(
        token: 'Bearer ${_sharedPreferences.getString('token')!}',
        id: id).then((http)async{
      if(http.response.statusCode != 200){
        return false;
      }
      else{
        return true;
      }
    });
  }

  Future<String?> getIsFavoriteByService(String type, String serviceId) async {
    return _appService.isFavorite(
        token: 'Bearer ${_sharedPreferences.getString('token')!}',
        type: type,
        service: serviceId
    ).then((http)async{
      if(http.response.statusCode != 200){
        return null;
      }
      else{
        return http.data.toFavoriteId();
      }
    });
  }
}