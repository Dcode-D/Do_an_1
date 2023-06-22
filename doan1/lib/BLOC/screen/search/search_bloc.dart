import 'package:bloc/bloc.dart';
import 'package:doan1/data/model/vehicle.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import '../../../data/model/hotel.dart';
import '../../../data/model/tour.dart';
import '../../../data/repositories/hotel_repo.dart';
import '../../../data/repositories/tour_repo.dart';
import '../../../data/repositories/vehicle_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState>{
  List<Vehicle>? listVehicle;
  List<Hotel>? listHotel;
  List<Tour>? listTour;
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

    on<GetTourForSearch>((event,emit) async {
      emit(SearchState(getTourData: SearchStatus.initial));

    });

    on<GetInitialData>((event,emit) async{
        listVehicle = await getinitialVehicle();
        listHotel = await getinitialHotel();
        listTour = await getinitialTour();
        if(listVehicle != null && listHotel != null){
          emit(SearchState(getInitialData: SearchStatus.success));
        }
        else{
          emit(SearchState(getInitialData: SearchStatus.failure));
        }
      });
  }

  Future<List<Hotel>?> getHotelByName(String name) async{
    var hotelRepo = GetIt.instance.get<HotelRepository>();
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
    var vehicleRepo = GetIt.instance.get<VehicleRepository>();
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
    var hotelRepo = GetIt.instance.get<HotelRepository>();
    try{
      var listHotel = await hotelRepo.getListHotelByQuery(1, null, null, null, null);
      return listHotel;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future<List<Vehicle>?> getinitialVehicle() async{
    var vehicleRepo = GetIt.instance.get<VehicleRepository>();
    try{
      var listVehicle = await vehicleRepo.getListVehicle(1);
      return listVehicle;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future<List<Tour>?> getinitialTour() async{
    var tourRepo = GetIt.instance.get<TourRepository>();
    try{
      var listTour = await tourRepo.getListTourByPage(1);
      return listTour;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}