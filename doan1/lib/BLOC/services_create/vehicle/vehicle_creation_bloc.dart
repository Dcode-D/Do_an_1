import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:doan1/data/repositories/vehicle_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../Utils/pick_files.dart';

part 'vehicle_creation_event.dart';
part 'vehicle_creation_state.dart';

class VehicleCreationBloc extends Bloc<VehicleCreationEvent, VehicleCreationState> {
  List<File> listImages = [];
  VehicleCreationBloc() : super(VehicleCreationInitial()) {
    final vehicleRepo = GetIt.instance.get<VehicleRepository>();
    on<VehicleCreationEvent>((event, emit) {

    });

    on<VehicleCreationImageEvent>((event, emit) async {
      if(event.method == ImageMethod.camera){
        var image = await FilesPicking.pickImageFromCamera();
        if(image != null){
          listImages.add(image);
          emit(VehicleCreationImageState(listImages));
        }
      }
      else if(event.method == ImageMethod.gallery){
        var image = await FilesPicking.pickImageFromGallery();
        if(image != null){
          listImages.add(image);
          emit(VehicleCreationImageState(listImages));
        }
      }
    });
    on<VehicleCreationImgRemoveEvent>((event, emit) async {
      listImages.removeAt(event.index);
      emit(VehicleCreationImageState(listImages));
    });
    on<VehicleCreationPostEvent>((event, emit) async {
      final rs = await vehicleRepo.createVehicle(
        event.data['plate'],
        event.data['brand'],
        event.data['color'],
        event.data['address'],
        event.data['province'],
        event.data['district'],
        event.data['description'],
        event.data['seats'],
        event.data['price'],
        listImages,
      );
      emit(VehicleCreationPostState(rs));
    });
  }
}
