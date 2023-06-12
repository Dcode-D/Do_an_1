import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'vehicle_booking_event.dart';
part 'vehicle_booking_state.dart';

class VehicleBookingBloc extends Bloc<VehicleBookingEvent,VehicleBookingState>{
  VehicleBookingBloc() : super(VehicleBookingState(isDateSet: false)) {
    on<SetBookingDate>((event,emit) => emit(VehicleBookingState(isDateSet: true)));
  }
}