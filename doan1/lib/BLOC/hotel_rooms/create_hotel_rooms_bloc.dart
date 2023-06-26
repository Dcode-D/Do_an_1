import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../data/model/hotel.dart';
import '../../data/model/hotelroom.dart';
import '../../data/repositories/hotel_repo.dart';
import '../../data/repositories/hotelroom_repo.dart';

part 'create_hotel_rooms_event.dart';
part 'create_hotel_rooms_state.dart';

class CreateHotelRoomsBloc extends Bloc<CreateHotelRoomsEvent, CreateHotelRoomsState> {
  List<HotelRoom> hotelRooms = [];
  Hotel? hotel;
  CreateHotelRoomsBloc() : super(CreateHotelRoomsInitial()) {
    on<CreateHotelRoomsInitialHotelEvent>((event, emit) async {
      print("Triggered");
      emit(CreateHotelRoomsReadyState(true, false));
      final hotelRepo = GetIt.instance.get<HotelRepository>();
      hotel = await hotelRepo.getHotelById(event.hotelId);
      if(hotel != null){
        emit(CreateHotelRoomsReadyState(false, true));
      }
      else{
        emit(CreateHotelRoomsReadyState(false, false));
      }
    });

    on<CreateHotelRoomsAddRoomEvent>((event, emit) async {
      hotelRooms.add(event.hotelRoom);
      emit(CreateHotelRoomsListRoomsChangedState(hotelRooms));
    });

    on<CreateHotelRoomsRemoveRoomEvent>((event, emit) async {
      hotelRooms.remove(event.hotelRoom);
      emit(CreateHotelRoomsListRoomsChangedState(hotelRooms));
    });

    on<CreateHotelRoomsPostEvent>((event, emit) async {
      emit(CreateHotelRoomsSuccessState(false, true));
      if(hotel != null){
        final hotelRoomsRepo = GetIt.instance.get<HotelRoomRepository>();
        final result = await hotelRoomsRepo.createHotelRoom(hotelRooms, hotel!.id as String);
        emit(CreateHotelRoomsSuccessState(result, false));
      }
      else{
        emit(CreateHotelRoomsSuccessState(false, false));
      }
    });

    on<CreateHotelRoomsCopyEvent>((event, emit) async {
      emit(CreateHotelRoomsCopyState(event.hotelRoom));
    });
  }
}
