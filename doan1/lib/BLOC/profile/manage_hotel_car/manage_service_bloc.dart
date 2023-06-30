import 'package:bloc/bloc.dart';
import 'package:doan1/EventBus/Events/DeleteHotelEventEVB.dart';
import 'package:doan1/EventBus/Events/DeleteVehicleEventEVB.dart';
import 'package:doan1/data/repositories/vehicle_repo.dart';
import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/hotel.dart';
import '../../../data/model/vehicle.dart';
import '../../../data/repositories/hotel_repo.dart';

part 'manage_service_state.dart';
part 'manage_service_event.dart';

class ManageServiceBloc extends Bloc<ManageServiceEvent,ManageServiceState>{
  List<Hotel>? listHotel;
  List<Vehicle>? listVehicle;

  List<Hotel>? listExtraHotel;
  List<Vehicle>? listExtraVehicle;
  ManageServiceBloc() : super(ManageServiceInitial()){
    on<GetDataByOwner>((event,emit) async {
      listHotel = await getListHotelByOwnerId(event.owner,event.page);
      listVehicle = await getListVehicleByOwnerId(event.owner,event.page);
      if(listHotel != null && listVehicle != null){
        emit(GetInitialDataState(true));
      }
      else{
        emit(GetInitialDataState(false));
      }
    });
    on<LoadMoreVehicleData>((event,emit) async {
      listExtraVehicle = null;
      listExtraVehicle = await getListVehicleByOwnerId(event.owner,event.page);
      if(listExtraVehicle == null){
        emit(LoadMoreVehicleDataState(false));
        return;
      }
      for (var i = 0; i < listExtraVehicle!.length; i++) {
        listVehicle!.add(listExtraVehicle![i]);
      }
      emit(LoadMoreVehicleDataState(true));
    });

    on<LoadMoreHotelData>((event,emit) async {
      listExtraHotel = null;
      listExtraHotel = await getListHotelByOwnerId(event.owner,event.page);
      if(listExtraHotel == null){
        emit(LoadMoreHotelDataState(false));
        return;
      }
      for (var i = 0; i < listExtraHotel!.length; i++) {
        listHotel!.add(listExtraHotel![i]);
        emit(LoadMoreHotelDataState(false));
      }
      emit(LoadMoreHotelDataState(true));
    });
    on<DeleteVehicleItem>((event,emit) async {
      if(listVehicle == null){
        emit(DeleteVehicleItemState(false));
        return;
      }
      if(event.vehicle == ""){
        emit(DeleteVehicleItemState(false));
        return;
      }
      listVehicle!.removeWhere((element) => element.id == event.vehicle);
      emit(DeleteVehicleItemState(true));
    });

    on<DeleteHotelItem>((event,emit) async {
      if(listHotel == null){
        emit(DeleteHotelItemOnManageState(false));
        return;
      }
      if(event.hotel == ""){
        emit(DeleteHotelItemOnManageState(false));
        return;
      }
      listHotel!.removeWhere((element) => element.id == event.hotel);
      emit(DeleteHotelItemOnManageState(true));
    });

    //listen when hotel or vehicle is deleted
    final eventBus = GetIt.instance.get<EventBus>();
    eventBus.on<DeleteVehicleEventEVB>().listen((event) {
      add(DeleteVehicleItem(event.vehicle));
    });
    eventBus.on<DeleteHotelEventEVB>().listen((event) {
      add(DeleteHotelItem(event.hotel));
    });
  }
  Future<List<Hotel>?> getListHotelByOwnerId(String owner, int page) async {
    var hotelRepo = GetIt.instance.get<HotelRepository>();
    try {
      var listHotel = await hotelRepo.getListHotelByOwner(owner, page);
      return listHotel;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future<List<Vehicle>?> getListVehicleByOwnerId(String owner, int page) async {
    var vehicleRepo = GetIt.instance.get<VehicleRepository>();
    try {
      var listVehicle = await vehicleRepo.getListVehicleByOwner(owner, page);
      return listVehicle;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}