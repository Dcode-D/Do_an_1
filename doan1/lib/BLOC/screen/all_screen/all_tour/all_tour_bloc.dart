import 'package:bloc/bloc.dart';
import 'package:doan1/data/repositories/tour_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/tour.dart';

part 'all_tour_event.dart';
part 'all_tour_state.dart';

class AllTourBloc extends Bloc<AllTourEvent,AllTourState>{
  List<Tour>? listTour;
  List<Tour>? extraListTour;
  AllTourBloc() : super(AllTourState(getListTourSuccess: false,
      getExtraListTourSuccess: false,
      maxData: false,
      isLoadingMore: false)){
    var _currentPage = 0;
    var _searchQuery = "";

    on<GetTourListEvent>((event, emit) async {
      listTour = [];
      _currentPage++;
      if(_searchQuery.isEmpty) {
        var tempList = await getTour(_currentPage, null, null, null, null);
        if (tempList != null) {
          listTour!.addAll(tempList);
          emit(AllTourState(
              getListTourSuccess: true,
              isLoadingMore: false,
              getExtraListTourSuccess: state.getExtraListTourSuccess,
              maxData: state.maxData
          ));
        }
        else {
          emit(AllTourState(
              getListTourSuccess: false,
              isLoadingMore: false,
              getExtraListTourSuccess: state.getExtraListTourSuccess,
              maxData: state.maxData
          ));
        }
      }
      else{
        var tempList = await getTour(_currentPage, null, null, null, _searchQuery);
        var tempList1 = await getTour(_currentPage, null, null, _searchQuery, null);
        var tempList2 = await getTour(_currentPage, null, _searchQuery, null, null);
        if (tempList != null) {
          listTour!.addAll(tempList);
          listTour!.addAll(tempList1!);
          listTour!.addAll(tempList2!);
          emit(AllTourState(
              getListTourSuccess: true,
              isLoadingMore: false,
              getExtraListTourSuccess: state.getExtraListTourSuccess,
              maxData: state.maxData
          ));
        }
        else {
          emit(AllTourState(
              getListTourSuccess: false,
              isLoadingMore: false,
              getExtraListTourSuccess: state.getExtraListTourSuccess,
              maxData: state.maxData
          ));
        }
      }
    });

    on<GetTourListExtraEvent>((event, emit) async{
      extraListTour = null;
      extraListTour = await getTour(event.page,null,null,null,null);
      if(extraListTour == null){
        emit(AllTourState(
            getExtraListTourSuccess: false,
            getListTourSuccess: state.getListTourSuccess,
            isLoadingMore: false,
            maxData: true
        ));
        return;
      }
      for (var i = 0; i < extraListTour!.length; i++) {
        listTour!.add(extraListTour![i]);
        emit(AllTourState(
            isLoadingMore: true,
            getListTourSuccess: state.getListTourSuccess,
            getExtraListTourSuccess: state.getExtraListTourSuccess,
            maxData: state.maxData
        ));
      }

      if(extraListTour != null && listTour != null){
        emit(AllTourState(
            getListTourSuccess: state.getListTourSuccess,
            getExtraListTourSuccess: true,
            maxData: state.maxData,
            isLoadingMore: false));
      }
      else{
        emit(AllTourState(
            getListTourSuccess: state.getListTourSuccess,
            getExtraListTourSuccess: false,
            maxData: state.maxData,
            isLoadingMore: false));
      }
    });

    on<GetTourByQuery>((event, emit) async {
      emit(AllTourState(
          getListTourSuccess: false,
          isLoadingMore: false,
          getExtraListTourSuccess: state.getExtraListTourSuccess,
          maxData: state.maxData
      ));
      _searchQuery = event.query;
      _currentPage = 0;
      listTour = [];
      add(GetTourListEvent());
    });
  }
  Future<List<Tour>?> getTour(int page,String? user, String? city, String? province, String? referenceName) async {
    var tourRepo = GetIt.instance.get<TourRepository>();
    try {
      var listTour = await tourRepo.getListHotelByQuery(page, user, city, province, referenceName);
      return listTour;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}

