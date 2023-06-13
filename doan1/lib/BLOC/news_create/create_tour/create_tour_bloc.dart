import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/model/article.dart';

part 'create_tour_event.dart';
part 'create_tour_state.dart';

class CreateTourBloc extends Bloc<CreateTourEvent,CreateTourState>{
  List<Article> listSelectedTourPlan = [];
  CreateTourBloc() : super(CreateTourInitial()) {
    on<SetTourPlan>((event,emit) {
      listSelectedTourPlan = event.tourPlan;
      emit(PlanSetState(isPlanSet: true));
      });
    on<RemoveTourPlan>((event,emit) {
      listSelectedTourPlan.removeAt(event.index);
      add(SetTourPlan(tourPlan: listSelectedTourPlan));
    });
  }
}