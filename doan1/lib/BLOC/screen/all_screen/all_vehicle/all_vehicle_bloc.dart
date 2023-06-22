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
  AllVehicleBloc() : super(AllVehicleState(getExtraListVehicleSuccess: false,getListVehicleSuccess: false,maxData: false,isLoadingMore: false)){
    on<GetVehicleListEvent>((event, emit) async {
      if(listVehicle == null){
        emit(AllVehicleState(getListVehicleSuccess: false,getExtraListVehicleSuccess: state.getExtraListVehicleSuccess,maxData: state.maxData,isLoadingMore: false));
      }

      listVehicle = await getVehicle(1);

      if(listVehicle != null){
        emit(AllVehicleState(getListVehicleSuccess: true,
            getExtraListVehicleSuccess: state.getExtraListVehicleSuccess,
            maxData: state.maxData,
            isLoadingMore: false));
      }
      else{
        emit(AllVehicleState(getListVehicleSuccess: false,
            getExtraListVehicleSuccess: state.getExtraListVehicleSuccess,
            maxData: state.maxData,
            isLoadingMore: false));
      }
    });
    on<GetVehicleListExtraEvent>((event, emit) async{

      extraListVehicle = await getVehicle(event.page);
      if(extraListVehicle == null){
        emit(AllVehicleState(
            getListVehicleSuccess: state.getListVehicleSuccess,
            getExtraListVehicleSuccess: false,
            maxData: true,
            isLoadingMore: false));
        return;
      }
      emit(AllVehicleState(
          getListVehicleSuccess: state.getListVehicleSuccess,
          getExtraListVehicleSuccess: state.getExtraListVehicleSuccess,
          maxData: state.maxData,
          isLoadingMore: true));
      for (var i = 0; i < extraListVehicle!.length; i++) {
        listVehicle!.add(extraListVehicle![i]);
      }

      if(extraListVehicle != null){
        emit(AllVehicleState(getListVehicleSuccess: state.getListVehicleSuccess,
            getExtraListVehicleSuccess: true,
            maxData: state.maxData,
            isLoadingMore: false));
      }
    });
  }
  Future<List<Vehicle>?> getVehicle(int page) async {
    var vehicleRepo = GetIt.instance.get<VehicleRepository>();
    try {
      var listHotel = await vehicleRepo.getListVehicle(page);
      return listHotel;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}

