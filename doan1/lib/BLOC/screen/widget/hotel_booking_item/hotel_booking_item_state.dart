part of 'hotel_booking_item_bloc.dart';

@immutable
abstract class HotelBookingItemState {}

class HotelBookingItemInitial extends HotelBookingItemState {
  bool getDataSuccess = false;
  HotelBookingItemInitial({required this.getDataSuccess});
}

class HotelBookingItemRejectSuccess extends HotelBookingItemState {
  bool rejectSuccess = false;
  HotelBookingItemRejectSuccess({required this.rejectSuccess});
}

class HotelBookingItemDeleteSuccess extends HotelBookingItemState {
  bool deleteSuccess = false;
  HotelBookingItemDeleteSuccess({required this.deleteSuccess});
}

class HotelBookingItemApproveSuccess extends HotelBookingItemState {
  bool approveSuccess = false;
  HotelBookingItemApproveSuccess({required this.approveSuccess});
}

