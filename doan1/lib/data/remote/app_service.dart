import 'package:dio/dio.dart';
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
  Future<HttpResponse> logout();
}