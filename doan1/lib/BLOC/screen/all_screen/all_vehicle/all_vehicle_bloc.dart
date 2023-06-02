import 'package:bloc/bloc.dart';
import 'package:doan1/data/model/vehicle.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../data/repositories/vehicle_repo.dart';

part 'all_vehicle_event.dart';
part 'all_vehicle_state.dart';

class AllVehicleBloc extends Bloc<AllVehicleEvent,AllVehicleState>{
  List<Vehicle>? listVehicle;
  List<Vehicle>? extraListVehicle;
  int? maxPage;
  AllVehicleBloc() : super(AllVehicleState(getExtraListVehicleSuccess: false,getListVehicleSuccess: false,maxData: false)){
    on<GetVehicleListEvent>((event, emit) async {
      if(listVehicle == null){
        emit(AllVehicleState(getListVehicleSuccess: false,getExtraListVehicleSuccess: state.getExtraListVehicleSuccess,maxData: state.maxData));
      }

      listVehicle = await getVehicle(1);

      if(listVehicle != null){
        emit(AllVehicleState(getListVehicleSuccess: true,getExtraListVehicleSuccess: state.getExtraListVehicleSuccess,maxData: state.maxData));
      }
      else{
        emit(AllVehicleState(getListVehicleSuccess: false,getExtraListVehicleSuccess: state.getExtraListVehicleSuccess,maxData: state.maxData));
      }
    });
    on<GetVehicleListExtraEvent>((event, emit) async{
      maxPage = await getMaxVehiclePage();
      if(maxPage! < event.page){
        emit(AllVehicleState(getListVehicleSuccess: state.getListVehicleSuccess,getExtraListVehicleSuccess: false,maxData: true));
        return;
      }

      if(listVehicle == null) {
        emit(AllVehicleState(getListVehicleSuccess: state.getListVehicleSuccess,getExtraListVehicleSuccess: false,maxData: state.maxData));
      }

      extraListVehicle = await getVehicle(event.page);
      for (var i = 0; i < extraListVehicle!.length; i++) {
        listVehicle!.add(extraListVehicle![i]);
      }

      if(listVehicle != null){
        emit(AllVehicleState(getListVehicleSuccess: state.getListVehicleSuccess,getExtraListVehicleSuccess: true,maxData: state.maxData));
      }
      else{
        emit(AllVehicleState(getListVehicleSuccess: state.getListVehicleSuccess,getExtraListVehicleSuccess: false,maxData: state.maxData));
      }
    });
  }
  Future<List<Vehicle>?> getVehicle(int page) async {
    var vehicleRepo = GetIt.instance.get<VehicleRepo>();
    try {
      var listHotel = await vehicleRepo.getListVehicle(page);
      return listHotel;
    }
    catch(e){
      print(e);
      return null;
    }
  }
  Future<int?> getMaxVehiclePage() async {
    var vehicleRepo = GetIt.instance.get<VehicleRepo>();
    try {
      var maxPage = await vehicleRepo.getMaxPage();
      return maxPage;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}

