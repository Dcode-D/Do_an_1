import 'package:dio/dio.dart';
import 'package:doan1/data/remote/app_service.dart';
import 'package:doan1/data/repositories/article_repo.dart';
import 'package:doan1/data/repositories/favorite_repo.dart';
import 'package:doan1/data/repositories/rating_repo.dart';
import 'package:doan1/data/repositories/tour_repo.dart';
import 'package:doan1/data/repositories/user_repo.dart';
import 'package:doan1/socketio/socketioRepo.dart';
import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/remote/dio.dart';
import '../data/remote/request_factory.dart';
import '../data/repositories/authenticator.dart';
import '../data/repositories/datebooking_repo.dart';
import '../data/repositories/hotel_repo.dart';
import '../data/repositories/hotelroom_repo.dart';
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
  UserRepository userRepo(Logger logger,
      SharedPreferences sharedPreferences,
      AppService appService, RequestFactory requestFactory, EventBus eventBus) =>
      UserRepository(logger, sharedPreferences, appService, requestFactory, eventBus);

  @singleton
  VehicleRepository vehicleRepo(Logger logger,
      SharedPreferences sharedPreferences,
      AppService appService, RequestFactory requestFactory, EventBus eventBus) =>
      VehicleRepository(logger, sharedPreferences, appService, requestFactory, eventBus);

  @singleton
  HotelRepository hotelRepo(Logger logger,
      SharedPreferences sharedPreferences,
      AppService appService, RequestFactory requestFactory, EventBus eventBus) =>
      HotelRepository(logger, sharedPreferences, appService, requestFactory, eventBus);

  @singleton
  HotelRoomRepository hotelRoomRepo(Logger logger,
      SharedPreferences sharedPreferences,
      AppService appService, RequestFactory requestFactory, EventBus eventBus) =>
      HotelRoomRepository(logger, sharedPreferences, appService, requestFactory, eventBus);

  @singleton
  ArticleRepository articleRepo(Logger logger,
      SharedPreferences sharedPreferences,
      AppService appService, RequestFactory requestFactory, EventBus eventBus) =>
      ArticleRepository(logger, sharedPreferences, appService, requestFactory, eventBus);

  @singleton
  SocketRepo socketRepo(SharedPreferences sharedPreferences, @Named("baseUrl")String baseUrl, EventBus eventBus) =>
      SocketRepo(sharedPreferences, baseUrl, eventBus);

  @singleton
  DateBookingRepository dateBookingRepo(Logger logger,
      SharedPreferences sharedPreferences,
      AppService appService, RequestFactory requestFactory, EventBus eventBus) =>
      DateBookingRepository(logger, sharedPreferences, appService, requestFactory, eventBus);

  @singleton
  TourRepository tourRepository(Logger logger,
      SharedPreferences sharedPreferences,
      AppService appService, RequestFactory requestFactory, EventBus eventBus) =>
      TourRepository(logger, sharedPreferences, appService, requestFactory, eventBus);

  @singleton
  FavoriteRepository favoriteRepo(Logger logger,
      SharedPreferences sharedPreferences,
      AppService appService, RequestFactory requestFactory, EventBus eventBus) =>
      FavoriteRepository(logger, sharedPreferences, appService, requestFactory, eventBus);

  @singleton
  RatingRepository ratingRepo(Logger logger,
      SharedPreferences sharedPreferences,
      AppService appService, RequestFactory requestFactory, EventBus eventBus) =>
      RatingRepository(logger, sharedPreferences, appService, requestFactory, eventBus);
}