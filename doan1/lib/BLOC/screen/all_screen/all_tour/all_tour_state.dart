part of 'all_tour_bloc.dart';

class AllTourState {
  bool? getListTourSuccess;
  bool isLoadingMore = false;
  bool? getExtraListTourSuccess;
  bool? maxData;
  AllTourState({this.getListTourSuccess,this.getExtraListTourSuccess,this.maxData,required this.isLoadingMore});
}