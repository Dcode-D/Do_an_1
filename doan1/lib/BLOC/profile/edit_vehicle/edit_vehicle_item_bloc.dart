import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/vehicle.dart';
import '../../../data/repositories/vehicle_repo.dart';

part 'edit_vehicle_item_event.dart';
part 'edit_vehicle_item_state.dart';

class EditVehicleItemBloc extends Bloc<EditVehicleItemEvent,EditVehicleItemState>{
  Vehicle? vehicle;
  List<String>? images;
  EditVehicleItemBloc() : super(EditVehicleItemInitial()){
    images = [];
    on<GetVehicleItemEvent>((event,emit) async {
      if(event.vehicleId == null){
        emit(EditVehicleItemLoaded(false));
        return;
      }
      var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
      emit(EditVehicleItemLoaded(false));
      vehicle = await getVehicleById(event.vehicleId);
      for (var item in vehicle!.images!){
        images!.add('$baseUrl/files/$item');
      }
      if(vehicle != null){
        emit(EditVehicleItemLoaded(true));
      }
      else{
        emit(EditVehicleItemLoaded(false));
      }
    });
    on<VehicleItemDeleteEvent>((event,emit) async {
      if(event.vehicleId == null){
        emit(EditVehicleItemDelete(false));
        return;
      }
      bool? result = await DeleteVehicleById(event.vehicleId);
      if(result == true){
        emit(EditVehicleItemDelete(true));
      }
      else{
        emit(EditVehicleItemDelete(false));
      }
    });
  }
  Future<Vehicle?> getVehicleById(String id) async{
    var vehicleRepo = GetIt.instance.get<VehicleRepo>();
    try{
      var vehicle = await vehicleRepo.getVehicleById(id);
      return vehicle;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future<bool?> DeleteVehicleById(String id) async{
    var vehicleRepo = GetIt.instance.get<VehicleRepo>();
    try{
      var result = await vehicleRepo.DeleteVehicleById(id);
      return result;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}