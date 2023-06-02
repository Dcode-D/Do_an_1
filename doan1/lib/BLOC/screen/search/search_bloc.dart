import 'package:bloc/bloc.dart';
import 'package:doan1/data/model/vehicle.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/repositories/vehicle_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState>{
  List<Vehicle>? listVehicle;
  SearchBloc() : super(SearchState(getData: SearchStatus.initial,getInitialData: SearchStatus.initial)){
    on<GetDataForSearch>((event, emit) async {
      emit(SearchState(getData: SearchStatus.initial));

      listVehicle = await getVehicleByBrand(event.brand);
      if(listVehicle != null){
        emit(SearchState(getData: SearchStatus.success));
      }
      else{
        emit(SearchState(getData: SearchStatus.failure));
      }
    });

    on<GetInitialData>((event,emit) async{
      emit(SearchState(getInitialData: SearchStatus.initial));

      listVehicle = await getintialVehicle();
      if(listVehicle != null){
        emit(SearchState(getInitialData: SearchStatus.success));
      }
      else{
        emit(SearchState(getInitialData: SearchStatus.failure));
      }
    });
  }

  Future<List<Vehicle>?> getVehicleByBrand(String brand) async{
    var vehicleRepo = GetIt.instance.get<VehicleRepo>();
    try{
      var listVehicle = await vehicleRepo.getListVehicleByBrand(brand);
      return listVehicle;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future<List<Vehicle>?> getintialVehicle() async{
    var vehicleRepo = GetIt.instance.get<VehicleRepo>();
    try{
      var listVehicle = await vehicleRepo.getListVehicle(1);
      return listVehicle;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}