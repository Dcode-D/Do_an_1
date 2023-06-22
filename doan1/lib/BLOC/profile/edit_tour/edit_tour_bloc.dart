import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/model/article.dart';
import '../../../data/model/hotel.dart';

part 'edit_tour_event.dart';
part 'edit_tour_state.dart';

class EditTourBloc extends Bloc<EditTourEvent,EditTourState>{
  List<Article> listSelectedTourPlan = [];
  List<Hotel> listSelectedHotel = [];
  EditTourBloc() : super(EditTourInitial()){

    on<SetEditTourPlan>((event,emit) {
      for(var i = 0; i < event.tourPlan.length; i++){
        listSelectedTourPlan.add(event.tourPlan[i]);
      }
      listSelectedTourPlan = listSelectedTourPlan.toSet().toList();
      emit(EditPlanSetState(isPlanSet: true));
    });

    on<RemoveEditTourPlan>((event,emit) {
      listSelectedTourPlan.removeWhere((element) => element.id == event.article.id);
      emit(EditPlanSetState(isPlanSet: true));
    });

    on<SetEditHotelPlan>((event,emit) {
      for(var i = 0; i < event.tourHotel.length; i++){
        listSelectedHotel.add(event.tourHotel[i]);
      }
      listSelectedHotel = listSelectedHotel.toSet().toList();
      emit(EditHotelSetState(isHotelSet: true));
    });

    on<RemoveEditHotelPlan>((event,emit) {
      listSelectedHotel.removeWhere((element) => element.id == event.hotel.id);
      emit(EditHotelSetState(isHotelSet: true));
    });
  }
}