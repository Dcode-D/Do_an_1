import 'package:dio/dio.dart';
import 'package:doan1/data/remote/app_service.dart';
import 'package:doan1/data/repositories/user_repo.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/remote/dio.dart';
import '../data/remote/request_factory.dart';
import '../data/repositories/authenticator.dart';
import '../data/repositories/hotel_repo.dart';
import '../data/repositories/vehicle_repo.dart';

@module
abstract class RegisterModule {
  @singleton
  @Named('baseUrl')
  String get baseUrl => "http://10.0.2.2:3500";

  @singleton
  Logger get logger => Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      printTime: false,
    ),
  );

  @singleton
  EventBus get eventBus => EventBus();

  @singleton
  @preResolve
  Future<SharedPreferences> sharedPreferences() => SharedPreferences.getInstance();

  @lazySingleton
  Dio dio(@Named('baseUrl') String baseUrl, Logger logger) => DioFactory(baseUrl).create(logger);

  @singleton
  AppService appService(Dio dio) => AppService(dio);

  @singleton
  Authenticator authenticator(Logger logger,
      SharedPreferences sharedPreferences,
      AppService appService, RequestFactory requestFactory, EventBus eventBus) =>
      Authenticator(logger, sharedPreferences, appService, requestFactory, eventBus);

  @singleton
  UserRepo userRepo(Logger logger,
      SharedPreferences sharedPreferences,
      AppService appService, RequestFactory requestFactory, EventBus eventBus) =>
      UserRepo(logger, sharedPreferences, appService, requestFactory, eventBus);

  @singleton
  VehicleRepo vehicleRepo(Logger logger,
      SharedPreferences sharedPreferences,
      AppService appService, RequestFactory requestFactory, EventBus eventBus) =>
      VehicleRepo(logger, sharedPreferences, appService, requestFactory, eventBus);

  @singleton
  HotelRepo hotelRepo(Logger logger,
      SharedPreferences sharedPreferences,
      AppService appService, RequestFactory requestFactory, EventBus eventBus) =>
      HotelRepo(logger, sharedPreferences, appService, requestFactory, eventBus);
}