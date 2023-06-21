import 'package:dio/dio.dart';
import 'package:doan1/data/repositories/vehicle_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../../../data/model/favorite.dart';
import '../../../data/model/vehicle.dart';

part 'car_item_event.dart';
part 'car_item_state.dart';

class CarItemBloc extends Bloc<CarItemEvent,CarItemState>{
  Vehicle? vehicle;
  List<String>? listImage;
  Favorite? favorite;
  CarItemBloc() : super(CarItemState(getCarItemSuccess: false)){
    listImage = [];
    on<GetCarItemEvent>((event, emit) async {
      if(event.vehicle == null){
        emit(CarItemState(getCarItemSuccess: false));
        return;
      }
      var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
      emit(CarItemState(getCarItemSuccess: false));
      var vehiclerepo = await GetIt.instance.get<VehicleRepo>();
      vehicle = await vehiclerepo.getVehicleById(event.vehicle!.id!);
      for (var item in vehicle!.images!){
        listImage!.add('$baseUrl/files/${item}');
      }
      if(vehicle != null){
        emit(CarItemState(getCarItemSuccess: true));
      }
      else{
        emit(CarItemState(getCarItemSuccess: false));
      }
    });
  }
}