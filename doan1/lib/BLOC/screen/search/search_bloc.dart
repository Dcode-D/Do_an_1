import 'package:bloc/bloc.dart';
import 'package:doan1/data/model/vehicle.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import '../../../data/model/hotel.dart';
import '../../../data/repositories/hotel_repo.dart';
import '../../../data/repositories/vehicle_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState>{
  List<Vehicle>? listVehicle;
  List<Hotel>? listHotel;
  SearchBloc() : super(SearchState(getData: SearchStatus.initial,getInitialData: SearchStatus.initial)){
    on<GetDataForSearch>((event, emit) async {
      emit(SearchState(getData: SearchStatus.initial));

      listVehicle = await getVehicleByBrand(event.searchText);
      listHotel = await getHotelByName(event.searchText);
      if(listVehicle != null && listHotel != null){
        emit(SearchState(getData: SearchStatus.success));
      }
      else{
        emit(SearchState(getData: SearchStatus.failure));
      }
    });

    on<GetInitialData>((event,emit) async{
      emit(SearchState(getInitialData: SearchStatus.initial));

      listVehicle = await getinitialVehicle();
      listHotel = await getinitialHotel();
      if(listVehicle != null && listHotel != null){
        emit(SearchState(getInitialData: SearchStatus.success));
      }
      else{
        emit(SearchState(getInitialData: SearchStatus.failure));
      }
    });
  }

  Future<List<Hotel>?> getHotelByName(String name) async{
    var hotelRepo = GetIt.instance.get<HotelRepo>();
    try{
      var listHotel = await hotelRepo.getListHotelByName(name);
      return listHotel;
    }
    catch(e){
      print(e);
      return null;
    }
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
  Future<List<Hotel>?> getinitialHotel() async{
    var hotelRepo = GetIt.instance.get<HotelRepo>();
    try{
      var listHotel = await hotelRepo.getListHotel(1);
      return listHotel;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future<List<Vehicle>?> getinitialVehicle() async{
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