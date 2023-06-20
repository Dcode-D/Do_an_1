part of 'booker_bloc.dart';

@immutable
abstract class BookerState {}

class BookerInitial extends BookerState {}

class BookingOrderLoad extends BookerState {
  final List<DateBooking> listHotelBookingOrder;
  final List<DateBooking> listVehicleBookingOrder;
  BookingOrderLoad(this.listVehicleBookingOrder, this.listHotelBookingOrder);
}

class BookingOrderLoadFail extends BookerState {}