import 'package:bloc/bloc.dart';
import 'package:doan1/data/repositories/user_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/datebooking.dart';
import '../../../../data/model/user.dart';
import '../../../../data/model/vehicle.dart';
import '../../../../data/repositories/datebooking_repo.dart';
import '../../../../data/repositories/vehicle_repo.dart';

part 'vehicle_booking_item_event.dart';
part 'vehicle_booking_item_state.dart';

class VehicleBookingItemBloc extends Bloc<VehicleBookingItemEvent,VehicleBookingItemState> {
  DateBooking? dateBooking;
  Vehicle? vehicle;
  User? owner;
  VehicleBookingItemBloc() : super(VehicleBookingItemInitial(getDataSuccess: false)) {
    on<VehicleBookingItemInitialEvent>((event,emit) async {
      dateBooking = event.dateBooking;
      vehicle = await getVehicleFunc(dateBooking!.attachedServices![0]) as Vehicle;
      owner = await getOwner(vehicle!.owner!);
      if(vehicle != null && owner != null){
        emit(VehicleBookingItemInitial(getDataSuccess: true));
        emit(VehicleBookingItemRejectSuccess(rejectSuccess: false));
      }
      else{
        emit(VehicleBookingItemInitial(getDataSuccess: false));
      }
    });
    on<VehicleBookingItemRejectEvent>((event,emit) async{
      bool rejectSuccess = await rejectDateBookingFunc(dateBooking!.id!);
      if(rejectSuccess == true){
        emit(VehicleBookingItemRejectSuccess(rejectSuccess: true));
      }
      else{
        emit(VehicleBookingItemRejectSuccess(rejectSuccess: false));
      }
    });
    on<VehicleBookingItemDeleteEvent>((event,emit)async{
      bool? deleteSuccess = await deleteDateBookingFunc(dateBooking!.id!);
      if(deleteSuccess == true){
        emit(VehicleBookingItemDeleteSuccess(deleteSuccess: true));
      }
      else{
        emit(VehicleBookingItemDeleteSuccess(deleteSuccess: false));
      }
    });
  }
  Future<Vehicle?> getVehicleFunc(String vehicleId) async{
    var vehicleRepo = GetIt.instance<VehicleRepo>();
    return vehicleRepo.getVehicleById(vehicleId).then((value) {
      if(value != null){
        return value;
      }
      else{
        return null;
      }
    });
  }

  Future<User?> getOwner(String id) async{
    var userRepo = GetIt.instance<UserRepo>();
    try {
      owner = await userRepo.getUserById(id);
      return owner;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future<bool> rejectDateBookingFunc(String dateBookingId) async{
    return GetIt.instance<DateBookingRepo>().RejectBookingDate(dateBookingId);
  }

  Future<bool?> deleteDateBookingFunc(String dateBookingId) async{
    return GetIt.instance<DateBookingRepo>().DeleteBookingDate(dateBookingId);
  }
}