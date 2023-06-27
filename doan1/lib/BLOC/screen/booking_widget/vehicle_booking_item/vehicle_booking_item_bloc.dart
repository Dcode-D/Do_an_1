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
  User? user;
  User? owner;
  int? index;
  VehicleBookingItemBloc() : super(VehicleBookingItemInitial(getDataSuccess: false)) {
    on<VehicleBookingItemInitialEvent>((event,emit) async {
      index = event.index;
      dateBooking = event.dateBooking;
      vehicle = await getVehicleFunc(dateBooking!.attachedServices![0]) as Vehicle;
      owner = await getOwner(vehicle!.owner!);
      user = await getUserFunc(event.dateBooking!.user!);
      if(vehicle != null && user != null){
        emit(VehicleBookingItemInitial(getDataSuccess: true));
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
    on<VehicleBookingItemApproveEvent>((event,emit)async{
      bool? approveSuccess = await approveDateBookingFunc(dateBooking!.id!);
      if(approveSuccess == true){
        emit(VehicleBookingItemApproveSuccess(approveSuccess: true));
      }
      else{
        emit(VehicleBookingItemApproveSuccess(approveSuccess: false));
      }
    });

    on<VehicleBookingItemRefreshEvent>((event,emit) async {
      if(dateBooking == null){
        emit(VehicleBookingItemInitial(getDataSuccess: false));
      }
      dateBooking = await getDateBookingById(dateBooking!.id!);
      vehicle = await getVehicleFunc(dateBooking!.attachedServices![0]) as Vehicle;
      owner = await getOwner(vehicle!.owner!);
      user = await getUserFunc(dateBooking!.user!);
      if(vehicle != null && user != null){
        emit(VehicleBookingItemInitial(getDataSuccess: true));
      }
      else{
        emit(VehicleBookingItemInitial(getDataSuccess: false));
      }
    });
  }
  Future<Vehicle?> getVehicleFunc(String vehicleId) async{
    var vehicleRepo = GetIt.instance<VehicleRepository>();
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
    var userRepo = GetIt.instance<UserRepository>();
    try {
      user = await userRepo.getUserById(id);
      return user;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future<bool> rejectDateBookingFunc(String dateBookingId) async{
    return GetIt.instance<DateBookingRepository>().RejectBookingDate(dateBookingId);
  }

  Future<bool?> deleteDateBookingFunc(String dateBookingId) async{
    return GetIt.instance<DateBookingRepository>().DeleteBookingDate(dateBookingId);
  }

  Future<bool?> approveDateBookingFunc(String dateBookingId) async{
    return GetIt.instance<DateBookingRepository>().ApproveBookingDate(dateBookingId);
  }

  Future<User?> getUserFunc(String userId) async{
    return GetIt.instance<UserRepository>().getUserById(userId);
  }

  Future<DateBooking?> getDateBookingById(String id) async {
    return GetIt.instance<DateBookingRepository>().GetDateBookingById(id);
  }
}