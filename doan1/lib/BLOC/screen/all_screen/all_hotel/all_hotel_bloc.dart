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
  AllHotelBloc() : super(AllHotelState(getListHotelSuccess: false, getExtraListHotelSuccess: false)){
    on<GetHotelListEvent>((event, emit) async {
      if(listHotel == null){
        emit(AllHotelState(getListHotelSuccess: false,getExtraListHotelSuccess: state.getExtraListHotelSuccess,maxData: state.maxData));
      }

      listHotel = await getHotel(1);

      if(listHotel != null){
        emit(AllHotelState(getListHotelSuccess: true,getExtraListHotelSuccess: state.getExtraListHotelSuccess,maxData: state.maxData));
      }
      else{
        emit(AllHotelState(getListHotelSuccess: false,getExtraListHotelSuccess: state.getExtraListHotelSuccess,maxData: state.maxData));
      }
    });
    on<GetHotelListExtraEvent>((event, emit) async{
      int? maxPage = await getMaxHotelPage();
      if(maxPage! < event.page){
        emit(AllHotelState(getListHotelSuccess: state.getListHotelSuccess,getExtraListHotelSuccess: false,maxData: true));
        return;
      }

      if(extraListHotel == null) {
        emit(AllHotelState(getListHotelSuccess: state.getListHotelSuccess,getExtraListHotelSuccess: false,maxData: state.maxData));
      }

      extraListHotel = await getHotel(event.page);
      for (var i = 0; i < extraListHotel!.length; i++) {
        listHotel!.add(extraListHotel![i]);
      }

      if(extraListHotel != null){
        emit(AllHotelState(getListHotelSuccess: state.getListHotelSuccess,getExtraListHotelSuccess: true,maxData: state.maxData));
      }
      else{
        emit(AllHotelState(getListHotelSuccess: state.getListHotelSuccess,getExtraListHotelSuccess: false,maxData: state.maxData));
      }
    });
  }
  Future<List<Hotel>?> getHotel(int page) async {
    var hotelRepo = GetIt.instance.get<HotelRepo>();
    try {
      var listHotel = await hotelRepo.getListHotel(page);
      return listHotel;
    }
    catch(e){
      print(e);
      return null;
    }
  }
  Future<int?> getMaxHotelPage() async {
    var hotelRepo = GetIt.instance.get<HotelRepo>();
    try {
      var maxPage = await hotelRepo.getMaxPage();
      return maxPage;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}