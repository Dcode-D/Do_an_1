import 'package:bloc/bloc.dart';
import 'package:doan1/EventBus/Events/NeedRefreshBookHistoryEvent.dart';
import 'package:doan1/EventBus/Events/NewBookingEvent.dart';
import 'package:doan1/data/model/datebooking.dart';
import 'package:doan1/data/model/vehicle.dart';
import 'package:doan1/data/repositories/datebooking_repo.dart';
import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/hotel.dart';
import '../../../data/repositories/hotel_repo.dart';
import '../../../data/repositories/vehicle_repo.dart';

part 'booker_event.dart';
part 'booker_state.dart';

class BookerBloc extends Bloc<BookerEvent,BookerState>{
  String type;
  String serviceId;
  late int page;
  List<DateBooking> listBookings = [];

  BookerBloc(this.type, this.serviceId) : super(BookerInitial()){
    page =0;
    on<BookerEvent>((event, emit) {
    });
    on<GetBookerEvent>((event, emit) async {
      page++;
      if(type == 'hotel'){
        var listHotelBooking = await getListHotelBooking(serviceId, page);
        if(listHotelBooking != null){
          listBookings.addAll(listHotelBooking);
          emit(BookingOrderLoad(listBookings));
        }
        else{
          emit(BookingOrderLoadFail());
        }
      }
      else if(type == 'car'){
        var listVehicleBooking = await getListVehicleBooking(serviceId, page);
        if(listVehicleBooking != null){
          listBookings.addAll(listVehicleBooking);
          emit(BookingOrderLoad(listBookings));
        }
        else{
          emit(BookingOrderLoadFail());
        }
      }
    });

    on<BookingRefreshed>((event, emit) async {
      listBookings = [];
      for(int i =1; i<=page; i++){
        if(type == 'hotel'){
          var listHotelBooking = await getListHotelBooking(serviceId, i);
          if(listHotelBooking != null){
            listBookings.addAll(listHotelBooking);
          }
          else{
            emit(BookingOrderLoadFail());
          }
        }
        else if(type == 'car'){
          var listVehicleBooking = await getListVehicleBooking(serviceId, i);
          if(listVehicleBooking != null){
            listBookings.addAll(listVehicleBooking);
          }
          else{
            emit(BookingOrderLoadFail());
          }
        }
        emit(BookingOrderLoad(listBookings));
      }
    });
    final eventbus = GetIt.instance.get<EventBus>();
    eventbus.on<NewBookingEvent>().listen((event) {
      if(!isClosed){
        add(BookingRefreshed());
      }
    });
    eventbus.on<NeedRefreshBookHistoryEvent>().listen((event) {
      if(!isClosed){
        add(BookingRefreshed());
      }
    });
  }
  Future<List<DateBooking>?> getListHotelBooking(String hoteId, int pg) async{
    var dateBookingRepo = GetIt.instance.get<DateBookingRepository>();
    try {
      var listHotelBooking = await dateBookingRepo.GetHotelBookingByHotelId(hoteId,pg);
      return listHotelBooking;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future<List<DateBooking>?> getListVehicleBooking(String vehicleId, int pg) async{
    var dateBookingRepo = GetIt.instance.get<DateBookingRepository>();
    try {
      var listVehicleBooking = await dateBookingRepo.GetVehicleBookingByVehicleId(vehicleId, pg);
      return listVehicleBooking;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}