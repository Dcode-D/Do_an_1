import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/datebooking_repo.dart';

part 'vehicle_booking_event.dart';
part 'vehicle_booking_state.dart';

class VehicleBookingBloc extends Bloc<VehicleBookingEvent,VehicleBookingState>{
  VehicleBookingBloc() : super(VehicleBookingState(isDateSet: false,isBookingSuccess: BookingState.initial)) {
    on<SetBookingDate>((event,emit) => emit(VehicleBookingState(isDateSet: true,isBookingSuccess: state.isBookingSuccess)));
    on<SetBooking>((event,emit) async {
      bool? bookResult = await CreateVehicleBooking(
          event.attachedServices!,
          event.startDate!,
          event.endDate!,
          event.user!,
          event.note,
          event.approved!,
          event.suspended!,
          event.type!);
      if(bookResult == true){
        emit(VehicleBookingState(isDateSet: state.isDateSet,isBookingSuccess: BookingState.success));
      }
      else{
        emit(VehicleBookingState(isDateSet: state.isDateSet,isBookingSuccess: BookingState.failure));
      }
    });

  }
  Future<bool?> CreateVehicleBooking(List<String> attachedServices,String startDate,String endDate,String user,String note,bool approved,bool suspended,String type) async{
    DateBookingRepo dateBookingRepo = GetIt.instance.get<DateBookingRepo>();
    try{
      var result = await dateBookingRepo.CreateBookingDate(attachedServices, startDate, endDate, user, note, approved, suspended, type);
      return result;
    }catch(e){
      print(e);
      return null;
    }
  }
}