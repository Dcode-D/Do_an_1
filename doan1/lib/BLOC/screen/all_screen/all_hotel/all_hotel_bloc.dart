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

    on<GetHotelListEvent>((event, emit) async {
      if(listHotel == null){
        emit(AllHotelState(
            getListHotelSuccess: false,
            getExtraListHotelSuccess: state.getExtraListHotelSuccess,
            maxData: state.maxData,
            isLoadingMore: false));
      }

      listHotel = await getHotel(1);

      if(listHotel != null){
        emit(AllHotelState(
            getListHotelSuccess: true,
            isLoadingMore: false,
            getExtraListHotelSuccess: state.getExtraListHotelSuccess,
            maxData: state.maxData
        ));
      }
      else{
        emit(AllHotelState(
            getListHotelSuccess: false,
            isLoadingMore: false,
            getExtraListHotelSuccess: state.getExtraListHotelSuccess,
            maxData: state.maxData
        ));
      }
    });

    on<GetHotelListExtraEvent>((event, emit) async{
      extraListHotel = null;
      extraListHotel = await getHotel(event.page);
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
  }
  Future<List<Hotel>?> getHotel(int page) async {
    var hotelRepo = GetIt.instance.get<HotelRepository>();
    try {
      var listHotel = await hotelRepo.getListHotel(page);
      return listHotel;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}