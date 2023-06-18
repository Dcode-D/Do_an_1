import 'dart:io';

import 'package:doan1/data/model/vehicle.dart';
import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../remote/app_service.dart';
import '../remote/request_factory.dart';

class VehicleRepo{
  final EventBus _eventBus;
  final Logger _logger;
  final SharedPreferences _sharedPreferences;
  final AppService _appService;
  final RequestFactory _requestFactory;

  VehicleRepo(this._logger, this._sharedPreferences, this._appService,
      this._requestFactory, this._eventBus);

  Future<Vehicle?> getVehicleById(String id) async{
    return _appService.getCarById(id).then((http)async{
      if(http.response.statusCode != 200){
        return null;
      }
      else{
        return http.data.toVehicle();
      }
    });
  }

  Future<List<Vehicle>?> getListVehicle(int page) async {
    return _appService
        .getListCarFromPage(page)
        .then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toListVehicle();
      }
    });
  }

  Future<List<Vehicle>?> getListVehicleByBrand(String brand, int page) async{
    return _appService
        .getListCarQuery(page, null, brand, null, null, null, null, null,null)
        .then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toListVehicle();
      }
    });
  }

  Future<List<Vehicle>?> getListVehicleByOwner(String owner, int page) async{
    return _appService
        .getListCarQuery(page, owner, null, null, null, null, null, null,null)
        .then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toListVehicle();
      }
    });
  }

  Future<bool> createVehicle(String plate, String brand, String color, String address, String province, String district,
      String description, int seats, double price, List<File> files) async{
    return _appService
        .createCar(
      token: "Bearer " + _sharedPreferences.getString("token")!,
      plate: plate,
      brand: brand,
      color: color,
      address: address,
      province: province,
      district: district,
      description: description,
      seats: seats,
      price: price,
      files: files,
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

  Future<bool?> DeleteVehicleById(String id) async{
    return _appService.deleteCarById(
        token: "Bearer ${_sharedPreferences.getString("token")!}",
        id: id)
        .then((http) async{
      if(http.response.statusCode != 200){
        return false;
      }
      else{
        return true;
      }
    });
  }
}