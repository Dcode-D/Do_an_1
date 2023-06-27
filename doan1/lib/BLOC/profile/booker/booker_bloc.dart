import 'package:bloc/bloc.dart';
import 'package:doan1/data/model/datebooking.dart';
import 'package:doan1/data/model/vehicle.dart';
import 'package:doan1/data/repositories/datebooking_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/hotel.dart';
import '../../../data/repositories/hotel_repo.dart';
import '../../../data/repositories/vehicle_repo.dart';

part 'booker_event.dart';
part 'booker_state.dart';

class BookerBloc extends Bloc<BookerEvent,BookerState>{
  List<DateBooking>? listHotelBookingOrder;
  List<DateBooking>? listVehicleBookingOrder;

  BookerBloc() : super(BookerInitial()){
    on<BookerEvent>((event, emit) {
    });
    on<GetBookerEvent>((event, emit) async {
      List<Hotel>? lsHotel = await getListHotelByOwnerId(event.ownerId, event.page);
      List<Vehicle>? lsVehicle = await getListVehicleByOwnerId(event.ownerId, event.page);
      if(lsHotel == null || lsVehicle == null){
        emit(BookingOrderLoadFail());
        return;
      }
      listHotelBookingOrder=[];
      listVehicleBookingOrder=[];
      for(var i in lsHotel){
        List<DateBooking>? listHotelBooking = await getListHotelBooking(i.id!);
        if(listHotelBooking == null){
          continue;
        }
        listHotelBookingOrder!.addAll(listHotelBooking);
      }
      for(var i in lsVehicle){
        List<DateBooking>? listVehicleBooking = await getListVehicleBooking(i.id!);
        if(listVehicleBooking == null){
          continue;
        }
        listVehicleBookingOrder!.addAll(listVehicleBooking);
      }

      emit(BookingOrderLoad(listVehicleBookingOrder!,listHotelBookingOrder!));
    });
  }
  Future<List<DateBooking>?> getListHotelBooking(String hoteId) async{
    var dateBookingRepo = GetIt.instance.get<DateBookingRepository>();
    try {
      var listHotelBooking = await dateBookingRepo.GetHotelBookingByHotelId(hoteId);
      return listHotelBooking;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future<List<DateBooking>?> getListVehicleBooking(String vehicleId) async{
    var dateBookingRepo = GetIt.instance.get<DateBookingRepository>();
    try {
      var listVehicleBooking = await dateBookingRepo.GetVehicleBookingByVehicleId(vehicleId);
      return listVehicleBooking;
    }
    catch(e){
      print(e);
      return null;
    }
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