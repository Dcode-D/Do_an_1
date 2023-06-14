part of 'vehicle_booking_bloc.dart';

@immutable
abstract class VehicleBookingEvent {}

class SetBookingDate extends VehicleBookingEvent{}

class SetBooking extends VehicleBookingEvent{
  List<String>? attachedServices;
  String? startDate;
  String? endDate;
  String? user;
  String note = "";
  bool? approved;
  bool? suspended;
  String? type;
  SetBooking({required this.attachedServices,required this.startDate,required this.endDate,required this.user,required this.note,required this.approved,required this.suspended,required this.type});
}