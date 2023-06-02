import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doan1/data/model/remote/avatar_file_response.dart';
import 'package:doan1/data/model/remote/list_model_response.dart';
import 'package:doan1/data/model/remote/login_response.dart';
import '../model/remote/base_response.dart';
import 'package:retrofit/retrofit.dart';

part 'app_service.g.dart';

@RestApi()
abstract class AppService {
  factory AppService(Dio dio, {String baseUrl}) = _AppService;

  @POST("/login")
  Future<HttpResponse<LoginResponse>> login(@Body() Map<String, dynamic> request);

  @GET("/logout")
  Future<HttpResponse> logout(@Header('Authorization') String token);

  @POST("/register")
  Future<HttpResponse> register(@Body() Map<String, dynamic> request);

  @GET("/user/full")
  Future<HttpResponse<BaseResponse>> getUser(@Header('Authorization') String token);

  @PUT("/user/update")
  Future<HttpResponse> updateUser(@Header('Authorization') String token, @Body() Map<String, dynamic> request);

  @GET("/avatar/list/{id}")
  Future<HttpResponse<AvatarResponse>> getListAvatarId(@Path('id') String id);

  @POST("/avatar/")
  @MultiPart()
  Future<HttpResponse> updateAvatar(@Header('Authorization') String token, @Part(name: "avatar") File file);

  @GET("/car/page")
  Future<HttpResponse<int>> getCarMaxPage();

  @GET("/hotel/page")
  Future<HttpResponse<int>> getHotelMaxPage();

  @GET("/car?page={page}&limit=10")
  Future<HttpResponse<ListModelResponse>> getListCarFromPage(@Path("page") int page);

  @GET("/car/{id}")
  Future<HttpResponse<BaseResponse>> getCarById(@Path('id') String id);

  @GET("/car?brand={brand}")
  Future<HttpResponse<ListModelResponse>> getListCarByBrand(@Path('brand') String brand);

  @GET("/hotel/page/{page}")
  Future<HttpResponse<ListModelResponse>> getListHotelFromPage(@Query('page') int page);

  @GET("/hotel/{id}/room")
  Future<HttpResponse<ListModelResponse>> getListHotelRoomById(@Path('id') String id);
}