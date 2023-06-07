import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/vehicle.dart';

part 'edit_vehicle_item_event.dart';
part 'edit_vehicle_item_state.dart';

class EditVehicleItemBloc extends Bloc<EditVehicleItemEvent,EditVehicleItemState>{
  Vehicle? vehicle;
  List<String>? images;
  EditVehicleItemBloc() : super(EditVehicleItemInitial()){
    images = [];
    on<GetVehicleItemEvent>((event,emit) async {
      if(event.vehicle == null){
        emit(EditVehicleItemLoaded(false));
        return;
      }
      var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
      emit(EditVehicleItemLoaded(false));
      vehicle = event.vehicle;
      for (var item in vehicle!.images!){
        images!.add('$baseUrl/files/${item}');
      }
      if(vehicle != null){
        emit(EditVehicleItemLoaded(true));
      }
      else{
        emit(EditVehicleItemLoaded(false));
      }
    });
  }

}