
import 'package:json_annotation/json_annotation.dart';

part 'datebooking.g.dart';

@JsonSerializable()
class DateBooking{
  @JsonKey(name: "_id")
  String? id;
  List<String>? attachedServices;
  DateTime? startDate;
  DateTime? endDate;
  String? user;
  String? note;
  bool? approved;
  bool? suspended;
  String? type;

  DateBooking({
    this.id,
    this.attachedServices,
    this.startDate,
    this.endDate,
    this.user,
    this.note,
    this.approved,
    this.suspended,
    this.type,
  });

  factory DateBooking.fromJson(Map<String, dynamic> json) => _$DateBookingFromJson(json);

  Map<String, dynamic> toJson() => _$DateBookingToJson(this);
}