part of 'book_history_bloc.dart';

@immutable
abstract class BookHistoryEvent {}


class GetNextHotelBooking extends BookHistoryEvent{}
class GetNextVehicleBooking extends BookHistoryEvent{}
class RefreshBookingHistoryEvent extends BookHistoryEvent{}