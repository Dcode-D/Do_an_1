import 'package:bloc/bloc.dart';
import 'package:doan1/data/repositories/user_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/datebooking.dart';
import '../../../../data/model/user.dart';
import '../../../../data/model/vehicle.dart';
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
      }
      else{
        emit(VehicleBookingItemInitial(getDataSuccess: false));
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
    }}
}