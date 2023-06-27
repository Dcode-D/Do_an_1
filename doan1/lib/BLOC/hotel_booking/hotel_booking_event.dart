part of 'hotel_booking_bloc.dart';
@immutable
abstract class HotelBookingEvent {}

class SetBookingDate extends HotelBookingEvent{}

class SetRoomEvent extends HotelBookingEvent{
  List<HotelRoom> hotelRoom = [];
  SetRoomEvent({required this.hotelRoom});
}

class RemoveRoomEvent extends HotelBookingEvent{
  int index;
  RemoveRoomEvent({required this.index});
}

class BookingRoomEvent extends HotelBookingEvent{
  List<String>? attachedServices;
  String? startDate;
  String? endDate;
  String? user;
  String note = "";
  bool? approved;
  bool? suspended;
  String? type;
  BookingRoomEvent({required this.attachedServices,required this.startDate,required this.endDate,required this.user,required this.note,required this.approved,required this.suspended,required this.type});
}

class RefreshHotelBookingEvent extends HotelBookingEvent {
  RefreshHotelBookingEvent();
}