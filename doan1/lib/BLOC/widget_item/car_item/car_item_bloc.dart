import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../../../data/model/vehicle.dart';

part 'car_item_event.dart';
part 'car_item_state.dart';

class CarItemBloc extends Bloc<CarItemEvent,CarItemState>{
  Vehicle? vehicle;
  List<String>? listImage;
  CarItemBloc() : super(CarItemState(getCarItemSuccess: false)){
    listImage = [];
    on<GetCarItemEvent>((event, emit) async {
      if(event.vehicle == null|| event.vehicle!.images == null){
        emit(CarItemState(getCarItemSuccess: false));
        return;
      }
      var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
      emit(CarItemState(getCarItemSuccess: false));
      vehicle = event.vehicle;
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