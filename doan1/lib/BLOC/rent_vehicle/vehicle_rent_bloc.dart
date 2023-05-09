
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'vehicle_rent_event.dart';
part 'vehicle_rent_state.dart';

class VehicleRentBloc extends Bloc<VehicleRentEvent, VehicleRentState>{

  VehicleRentBloc() : super(VehicleRentState(needDriver: false)) {
    on<CheckNeedDriverEvent>((event, emit) => emit(VehicleRentState(needDriver: event.needDriver)));
    on<UnCheckNeedDriverlEvent>((event, emit) => emit(VehicleRentState(needDriver: event.needDriver)));
  }
}