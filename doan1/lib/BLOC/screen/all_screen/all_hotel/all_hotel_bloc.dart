import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/hotel.dart';
import '../../../../data/repositories/hotel_repo.dart';

part 'all_hotel_event.dart';
part 'all_hotel_state.dart';

class AllHotelBloc extends Bloc<AllHotelEvent,AllHotelState>{
  List<Hotel>? listHotel;
  List<Hotel>? extraListHotel;
  AllHotelBloc() : super(AllHotelState(getListHotelSuccess: false,
      getExtraListHotelSuccess: false,
      maxData: false,
      isLoadingMore: false)){
    var _currentPage = 0;
    var _searchQuery = "";
    on<GetHotelListEvent>((event, emit) async {
      listHotel = [];
      _currentPage++;
      if(_searchQuery.isEmpty) {
        var tempList = await getHotel(_currentPage, null, null, null, null);
        if (tempList != null) {
          listHotel!.addAll(tempList);
          emit(AllHotelState(
              getListHotelSuccess: true,
              isLoadingMore: false,
              getExtraListHotelSuccess: state.getExtraListHotelSuccess,
              maxData: state.maxData
          ));
        }
        else {
          emit(AllHotelState(
              getListHotelSuccess: false,
              isLoadingMore: false,
              getExtraListHotelSuccess: state.getExtraListHotelSuccess,
              maxData: state.maxData
          ));
        }
      }
      else{
        var tempList = await getHotel(_currentPage, null, null, null, _searchQuery);
        var tempList1 = await getHotel(_currentPage, null, null, _searchQuery, null);
        var tempList2 = await getHotel(_currentPage, null, _searchQuery, null, null);
        var tempList3 = await getHotel(_currentPage, _searchQuery, null, null, null);
        if (tempList != null) {
          listHotel!.addAll(tempList);
          listHotel!.addAll(tempList1!);
          listHotel!.addAll(tempList2!);
          listHotel!.addAll(tempList3!);
          emit(AllHotelState(
              getListHotelSuccess: true,
              isLoadingMore: false,
              getExtraListHotelSuccess: state.getExtraListHotelSuccess,
              maxData: state.maxData
          ));
        }
        else {
          emit(AllHotelState(
              getListHotelSuccess: false,
              isLoadingMore: false,
              getExtraListHotelSuccess: state.getExtraListHotelSuccess,
              maxData: state.maxData
          ));
        }
      }
    });

    on<GetHotelListExtraEvent>((event, emit) async{
      extraListHotel = null;
      extraListHotel = await getHotel(event.page,null,null,null,null);
      if(extraListHotel == null){
        emit(AllHotelState(
            getExtraListHotelSuccess: false,
            getListHotelSuccess: state.getListHotelSuccess,
            isLoadingMore: false,
            maxData: true
        ));
        return;
      }
      for (var i = 0; i < extraListHotel!.length; i++) {
        listHotel!.add(extraListHotel![i]);
        emit(AllHotelState(
            isLoadingMore: true,
            getListHotelSuccess: state.getListHotelSuccess,
            getExtraListHotelSuccess: state.getExtraListHotelSuccess,
            maxData: state.maxData
        ));
      }

      if(extraListHotel != null && listHotel != null){
        emit(AllHotelState(
            getListHotelSuccess: state.getListHotelSuccess,
            getExtraListHotelSuccess: true,
            maxData: state.maxData,
            isLoadingMore: false));
      }
      else{
        emit(AllHotelState(
            getListHotelSuccess: state.getListHotelSuccess,
            getExtraListHotelSuccess: false,
            maxData: state.maxData,
            isLoadingMore: false));
      }
    });

    on<GetHotelByQuery>((event, emit) async {
      emit(AllHotelState(
          getListHotelSuccess: false,
          isLoadingMore: false,
          getExtraListHotelSuccess: state.getExtraListHotelSuccess,
          maxData: state.maxData
      ));
      _searchQuery = event.query;
      _currentPage = 0;
      listHotel = [];
      add(GetHotelListEvent());
    });
  }
  Future<List<Hotel>?> getHotel(int page,String? city, String? province, String? name, String? address) async {
    var hotelRepo = GetIt.instance.get<HotelRepository>();
    try {
      var listHotel = await hotelRepo.getListHotelByQuery(page, city, province, name, address);
      return listHotel;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}