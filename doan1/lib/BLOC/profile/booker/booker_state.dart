part of 'booker_bloc.dart';

@immutable
abstract class BookerState {}

class BookerInitial extends BookerState {}

class BookingOrderLoad extends BookerState {
  final List<DateBooking> listBooking;
  BookingOrderLoad(this.listBooking);
}

class BookingOrderLoadFail extends BookerState {}