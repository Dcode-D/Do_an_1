import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../Utils/image_pick_method.dart';
import '../../../Utils/pick_files.dart';
import '../../../data/model/vehicle.dart';
import '../../../data/repositories/vehicle_repo.dart';

part 'edit_vehicle_item_event.dart';
part 'edit_vehicle_item_state.dart';

class EditVehicleItemBloc extends Bloc<EditVehicleItemEvent,EditVehicleItemState>{
  Vehicle? vehicle;
  List<String>? images;
  int? index;
  EditVehicleItemBloc() : super(EditVehicleItemInitial()){
    on<GetVehicleItemEvent>((event,emit) async {
      images = [];
      if(event.vehicleId == null){
        emit(EditVehicleItemLoaded(false, false));
        return;
      }
      var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
      vehicle = await getVehicleById(event.vehicleId);
      for (var item in vehicle!.images!){
        images!.add('$baseUrl/files/$item');
      }
      if(vehicle != null){
        emit(EditVehicleItemLoaded(true, false));
      }
      else{
        emit(EditVehicleItemLoaded(false, false));
      }
    });

    on<VehicleItemRefreshEvent>(
        (event,emit) async {
          if (vehicle != null)
            add(GetVehicleItemEvent(vehicleId: vehicle!.id!));
        }
    );

    on<VehicleItemDeleteImageEvent>(
        (event,emit) async {
          if (vehicle != null){
            final vehicleRepo = GetIt.instance.get<VehicleRepository>();
            var result = await vehicleRepo.deleteVehicleImage(vehicle!.id!, vehicle!.images![event.index]);
            emit(EditVehicleItemModified(result));
            add(VehicleItemRefreshEvent());
          }
          else{
            emit(EditVehicleItemModified(false));
          }
        }
    );

    on<VehicleItemAddImageEvent>(
        (event, emit)async{
          if (vehicle != null){
            File? file;
            if(event.method == ImagePickMethod.GALLERY){
              file = await FilesPicking.pickImageFromGallery();
            }
            else if(event.method == ImagePickMethod.CAMERA){
              file = await FilesPicking.pickImageFromCamera();
            }
            if(file != null){
              final vehicleRepo = GetIt.instance.get<VehicleRepository>();
              var result = await vehicleRepo.addVehicleImage(vehicle!.id!, file);
              emit(EditVehicleItemModified(result));
              add(VehicleItemRefreshEvent());
            }
            else{
              emit(EditVehicleItemModified(false));
            }
          }
          else{
            emit(EditVehicleItemModified(false));
          }
        }
    );

    on<VehicleItemEditEvent>(
        (event, emit)async{
          if (vehicle != null){
            final vehicleRepo = GetIt.instance.get<VehicleRepository>();
            var result = await vehicleRepo.updateVehicle(vehicle!.id!, event.brand, event.price, event.color, event.description, event.address, event.seats);
            emit(EditVehicleItemModified(result));
            add(VehicleItemRefreshEvent());
          }
          else{
            emit(EditVehicleItemModified(false));
          }
        }
    );


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
    var vehicleRepo = GetIt.instance.get<VehicleRepository>();
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
    var vehicleRepo = GetIt.instance.get<VehicleRepository>();
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