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

  Future<bool> createTour(String name, String description, double rating, List<String> plans, int duration,double price, int maxGroupSize) async{
    final response = await _appService.createTour(token:"Bearer "+_sharedPreferences.getString("token")!, request:_requestFactory.createPostTour(name, description, rating, plans, duration, price, maxGroupSize));
    return response.response.statusCode == 200;
  }
}