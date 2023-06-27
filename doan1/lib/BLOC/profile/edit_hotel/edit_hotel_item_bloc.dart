import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doan1/Utils/image_pick_method.dart';
import 'package:doan1/Utils/pick_files.dart';
import 'package:doan1/data/repositories/hotel_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/hotel.dart';
import '../../../data/model/hotelroom.dart';
import '../../../data/repositories/hotelroom_repo.dart';

part 'edit_hotel_item_event.dart';
part 'edit_hotel_item_state.dart';

class EditHotelItemBloc extends Bloc<EditHotelItemEvent,EditHotelItemState>{
  Hotel? hotel;
  List<String>? images;
  List<HotelRoom>? listHotelRoom;
  int? index;
  EditHotelItemBloc() : super(EditHotelItemInitial()){
    on<GetHotelItemEvent>((event,emit) async {
      images = [];
      if(event.hotel == null){
        emit(EditHotelItemLoaded(false, loading: false));
        return;
      }
      var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
      emit(EditHotelItemLoaded(false, loading: true));
      // hotel = await getHotelById(event.hotelId);
      hotel = event.hotel;
      for (var item in hotel!.images!){
        images!.add('$baseUrl/files/$item');
      }
      listHotelRoom = await getListHotelRoomFunc(hotel!.id!);

      if(hotel != null && images != null && listHotelRoom != null){
        emit(EditHotelItemLoaded(true, loading: false));
      }
      else{
        emit(EditHotelItemLoaded(false, loading: false));
      }
    });

    on<DeleteHotelRoomEvent>((event,emit) async {
      if(hotel == null || listHotelRoom == null){
        emit(DeleteHotelRoomState(false));
        return;
      }
      bool? result = await deleteHotelRoomById(hotel!.id!,listHotelRoom![event.index].id!);
      if(result == true){
        listHotelRoom!.removeAt(event.index);
        emit(DeleteHotelRoomState(true));
        emit(EditHotelItemLoaded(true, loading: false));
      }
      else{
        emit(DeleteHotelRoomState(false));
        emit(EditHotelItemLoaded(true, loading: false));
      }
    });

    on<UpdateHotelRoomEvent>((event,emit) async {
      if(hotel == null || listHotelRoom == null){
        emit(UpdateHotelRoomState(false));
        return;
      }
      bool? result = await updateHotelRoomById(hotel!.id!,listHotelRoom![event.index].id!,event.hotelRoom);
      if(result == true){
        listHotelRoom![event.index] = event.hotelRoom;
        emit(UpdateHotelRoomState(true));
        emit(EditHotelItemLoaded(true, loading: false));
      }
      else{
        emit(UpdateHotelRoomState(false));
        emit(EditHotelItemLoaded(true, loading: false));
      }
    });

    on<DeleteHotelItemEvent>((event,emit) async{
      if(event.hotelId == null){
        emit(DeleteHotelItemState(false));
        return;
      }
      bool? result = await deleteHotelById(event.hotelId);
      if(result == true){
        emit(DeleteHotelItemState(true));
      }
      else{
        emit(DeleteHotelItemState(false));
      }
    });
    on<RefreshHotelItemEvent>((event,emit) async{
      if(hotel!=null&&hotel!.id!=null) {
        emit(EditHotelItemLoaded(false,loading: true));
        hotel = await getHotelById(hotel!.id!);
        if(hotel != null){
          emit(EditHotelItemLoaded(true, loading: false));
          images = [];
          add(GetHotelItemEvent(hotel: hotel!));
        }
        else{
          emit(EditHotelItemLoaded(false,loading: false));
        }
      }
    });
    on<DeleteHotelImageEvent>((event,emit)async{
      if(hotel!=null) {
        var hotelRepo = GetIt.instance.get<HotelRepository>();
        var result = await hotelRepo.DeleteHotelImage(hotel!.id!, hotel!.images![event.index]);
        emit(EditHotelResult(result as bool));
      }
    });
    on<AddImageEvent>((event,emit) async{
      if(hotel!=null) {
        var hotelRepo = GetIt.instance.get<HotelRepository>();
        if(event.method == ImagePickMethod.CAMERA){
          final file = await FilesPicking.pickImageFromCamera();
          if(file != null){
            var result = await hotelRepo.UploadHotelImage(hotel!.id!, file);
            emit(EditHotelResult(result as bool));
            if(result)
              add(RefreshHotelItemEvent());
          }
          else{
            emit(EditHotelResult(false));
          }
        }
        else if(event.method == ImagePickMethod.GALLERY){
          final file = await FilesPicking.pickImageFromGallery();
          if(file != null){
            var result = await hotelRepo.UploadHotelImage(hotel!.id!, file);
            emit(EditHotelResult(result as bool));
            if(result)
              add(RefreshHotelItemEvent());
          }
          else{
            emit(EditHotelResult(false));
          }
        }
      }
    });

    on<SaveHotelInfoEvent>((event,emit) async{
      if(hotel!=null) {
        var hotelRepo = GetIt.instance.get<HotelRepository>();
        List<String> facilities = [];
        for(var item in event.facilities.split(",")){
          facilities.add(item.trim());
        }
        hotel = new Hotel(id: hotel!.id!,
            name: event.name,
            address: event.address,
            owner: "",
            images: [],
            province: hotel!.province,
            city: hotel!.city,
            facilities: facilities,
            maxPrice: 0,
            minPrice: 0);
        var result = await hotelRepo.UpdateHotelInfo(hotel as Hotel);
        emit(EditHotelResult(result as bool));
        if(result)
          add(RefreshHotelItemEvent());
      }
      else
        emit(EditHotelResult(false));
    });

  }
  Future<List<HotelRoom>?> getListHotelRoomFunc(String hotelID) async{
    var hotelRoomRepo = GetIt.instance.get<HotelRoomRepository>();
    try{
      var listHotelRoom = await hotelRoomRepo.getHotelRoomList(hotelID);
      return listHotelRoom;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<Hotel?> getHotelById(String id) async{
    var hotelRepo = GetIt.instance.get<HotelRepository>();
    try{
      var hotel = await hotelRepo.getHotelById(id);
      return hotel;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<bool?> deleteHotelById(String id) async{
    var hotelRepo = GetIt.instance.get<HotelRepository>();
    try{
      var result = await hotelRepo.DeleteHotelById(id);
      return result;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<bool?> updateHotelRoomById(String id, String room, HotelRoom hotelRoom) async{
    var hotelRoomRepo = GetIt.instance.get<HotelRoomRepository>();
    try{
      var result = await hotelRoomRepo.updateHotelRoom(id,room,hotelRoom);
      return result;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<bool?> deleteHotelRoomById(String id, String room) async {
    var hotelRoomRepo = GetIt.instance.get<HotelRoomRepository>();
    try{
      var result = await hotelRoomRepo.deleteHotelRoom(id,room);
      return result;
    }catch(e){
      print(e);
      return null;
    }
  }
}