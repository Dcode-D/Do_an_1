import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:doan1/data/repositories/hotel_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../Utils/pick_files.dart';

part 'hotel_creation_event.dart';
part 'hotel_creation_state.dart';

class HotelCreationBloc extends Bloc<HotelCreationEvent, HotelCreationState> {
  var hotelid = "";
  var listImages = <File>[];
  HotelCreationBloc() : super(HotelCreationInitial()) {
    final hotelRepo = GetIt.instance.get<HotelRepository>();
    on<HotelCreationEvent>((event, emit) {
    });
    on<HotelCreationImageEvent>((event, emit) async {
      if(event.method == ImageMethod.camera){
        var image = await FilesPicking.pickImageFromCamera();
        if(image != null){
          listImages.add(image);
          emit(HotelCreationImageState(listImages));
        }
      }
      else if(event.method == ImageMethod.gallery){
        var image = await FilesPicking.pickImageFromGallery();
        if(image != null){
          listImages.add(image);
          emit(HotelCreationImageState(listImages));
        }
      }
    });
    on<HotelCreationRemoveImgEvent>((event, emit) async {
      listImages.removeAt(event.index);
      emit(HotelCreationImageState(listImages));
    });

    on<HotelCreationPostEvent>((event, emit) async {
      List<String> facilities = [];
      for (var i = 0; i < event.facilities.length; i++) {
        facilities.add(
          event.facilities[i]
        );
      }
      final (rs,hotelid) = await hotelRepo.createHotel(
        event.name,
        event.description,
        event.address,
        event.province,
        event.district,
        facilities,
        listImages,
      );
      emit(HotelCreationPostState(rs,hotelid));
    });
  }
}
