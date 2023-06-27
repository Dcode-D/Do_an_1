
import 'package:doan1/data/model/remote/base_response.dart';
import 'package:doan1/data/model/remote/list_model_response.dart';
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
  double? price;

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
    this.price
  });

  factory DateBooking.fromJson(Map<String, dynamic> json) => _$DateBookingFromJson(json);

  Map<String, dynamic> toJson() => _$DateBookingToJson(this);
}

extension DateBookingExtension on ListModelResponse{
  List<DateBooking>? toListDateBooking(){
    if(this.data.length == 0)
      return null;
    List<DateBooking> rs = [];
    for(Map<String, dynamic> item in this.data){
      rs.add(DateBooking.fromJson(item));
    }
    print("List date booking: $rs");
    return rs;
  }
}

extension DateBookingItemExtension on BaseResponse{
  DateBooking? toDateBooking(){
    if(this.data == null)
      return null;
    return DateBooking.fromJson(this.data!);
  }
}