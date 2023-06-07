import 'package:bloc/bloc.dart';
import 'package:doan1/data/model/vehicle.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import '../../../data/model/hotel.dart';
import '../../../data/repositories/hotel_repo.dart';
import '../../../data/repositories/vehicle_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

//TODO: Bad design triggering multiple searching events for both car and hotel at once
//TODO: Separate the logic of searching for car and hotel, add function to read more data and append to list when UI requires
class SearchBloc extends Bloc<SearchEvent,SearchState>{
  List<Vehicle>? listVehicle;
  List<Hotel>? listHotel;
  SearchBloc() : super(SearchState(getHotelData: SearchStatus.initial,getCarData: SearchStatus.initial,getInitialData: SearchStatus.initial)){
    on<GetHotelForSearch>((event, emit) async {
      emit(SearchState(getHotelData: SearchStatus.initial));

      listHotel = await getHotelByName(event.searchText);
      if(listVehicle != null && listHotel != null){
        emit(SearchState(getHotelData: SearchStatus.success));
      }
      else{
        emit(SearchState(getHotelData: SearchStatus.failure));
      }
    });

    on<GetVehicleForSearch>((event, emit) async {
      emit(SearchState(getCarData: SearchStatus.initial));

      listVehicle = await getVehicleByBrand(event.searchText);
      if(listVehicle != null){
        emit(SearchState(getCarData: SearchStatus.success));
      }
      else{
        emit(SearchState(getCarData: SearchStatus.failure));
      }
    });

    on<GetInitialData>((event,emit) async{
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
      var listHotel = await hotelRepo.getListHotelByName(name,1);
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
      //TODO: pass in the page number from outside
      var listVehicle = await vehicleRepo.getListVehicleByBrand(brand,1);
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