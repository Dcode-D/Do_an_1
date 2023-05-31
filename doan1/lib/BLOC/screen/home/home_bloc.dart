import 'package:doan1/data/repositories/vehicle_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../../../data/model/vehicle.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  List<Vehicle>? listVehicle;
  int page = 1;

  HomeBloc() : super(HomeState(getVehicleSuccess: false)){

    on<GetVehicleForScreenEvent>((event, emit) async {
      emit(HomeState(getVehicleSuccess: false));
      listVehicle = await getVehicle(page);
      if(listVehicle != null){
        emit(HomeState(getVehicleSuccess: true));
      }
      else{
        emit(HomeState(getVehicleSuccess: false));
      }
    });
  }
  Future<List<Vehicle>?> getVehicle(int page) async {
    var vehicleRepo = GetIt.instance.get<VehicleRepo>();
    try {
      listVehicle = await vehicleRepo.getVehicle(page);
      return listVehicle;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}