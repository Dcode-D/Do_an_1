part of 'all_hotel_bloc.dart';

class AllHotelState {
  bool? getListHotelSuccess;
  bool isLoadingMore = false;
  bool? getExtraListHotelSuccess;
  bool? maxData;
  AllHotelState({this.getListHotelSuccess,this.getExtraListHotelSuccess,this.maxData,required this.isLoadingMore});
}