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

  @GET("/car/")
  Future<HttpResponse<ListModelResponse>> getListCarFromPage(@Query("page") int page);
}