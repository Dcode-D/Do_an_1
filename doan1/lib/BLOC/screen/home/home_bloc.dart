import 'package:doan1/data/repositories/vehicle_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../../../data/model/hotel.dart';
import '../../../data/model/vehicle.dart';
import '../../../data/repositories/hotel_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  List<Vehicle>? listVehicle;
  List<Hotel>? listHotel;
  int page = 1;

  HomeBloc() : super(HomeState(getDataSuccess: false)){

    on<GetDataForScreenEvent>((event, emit) async {
      emit(HomeState(getDataSuccess: false));
      listVehicle = await getVehicle(page);
      listHotel = await getHotel(page);

      if(listVehicle != null && listHotel != null){
        emit(HomeState(getDataSuccess: true));
      }
      else{
        emit(HomeState(getDataSuccess: false));
      }
    });
  }
  Future<List<Vehicle>?> getVehicle(int page) async {
    var vehicleRepo = GetIt.instance.get<VehicleRepository>();
    try {
      listVehicle = await vehicleRepo.getListVehicle(page);
      return listVehicle;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future<List<Hotel>?> getHotel(int page) async {
    var hotelRepo = GetIt.instance.get<HotelRepository>();
    try {
      var listHotel = await hotelRepo.getListHotelByQuery(page, null, null, null, null);
      return listHotel;
    }
    catch(e){
      print(e);
      return null;
    }
  }

}