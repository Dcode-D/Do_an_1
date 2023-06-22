import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/model/article.dart';

part 'edit_tour_event.dart';
part 'edit_tour_state.dart';

class EditTourBloc extends Bloc<EditTourEvent,EditTourState>{
  List<Article> listSelectedTourPlan = [];
  EditTourBloc() : super(EditTourInitial()){

    on<SetEditTourPlan>((event,emit) {
      for(var i = 0; i < event.tourPlan.length; i++){
        listSelectedTourPlan.add(event.tourPlan[i]);
      }
      listSelectedTourPlan = listSelectedTourPlan.toSet().toList();
      emit(EditPlanSetState(isPlanSet: true));
    });

    on<RemoveEditTourPlan>((event,emit) {
      listSelectedTourPlan.remove(event.article);
      emit(EditPlanSetState(isPlanSet: true));
    });
  }
}