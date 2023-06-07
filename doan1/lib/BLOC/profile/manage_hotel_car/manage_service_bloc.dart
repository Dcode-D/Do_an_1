import 'package:bloc/bloc.dart';
import 'package:doan1/data/repositories/vehicle_repo.dart';
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
  ManageServiceBloc() : super(ManageServiceInitial()){
    on<GetDataByOwner>((event,emit) async {
      emit(GetInitialDataState(false));
      listHotel = await getListHotelByOwnerId(event.owner);
      listVehicle = await getListVehicleByOwnerId(event.owner);
      if(listHotel != null && listVehicle != null){
        emit(GetInitialDataState(true));
      }
      else{
        emit(GetInitialDataState(false));
      }
    });
  }
  Future<List<Hotel>?> getListHotelByOwnerId(String owner) async {
    var hotelRepo = GetIt.instance.get<HotelRepo>();
    try {
      var listHotel = await hotelRepo.getListHotelByOwner(owner, 1);
      return listHotel;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future<List<Vehicle>?> getListVehicleByOwnerId(String owner) async {
    var vehicleRepo = GetIt.instance.get<VehicleRepo>();
    try {
      var listVehicle = await vehicleRepo.getListVehicleByOwner(owner, 1);
      return listVehicle;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}