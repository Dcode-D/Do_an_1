import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/article.dart';

part 'create_tour_event.dart';
part 'create_tour_state.dart';

class CreateTourBloc extends Bloc<CreateTourEvent,CreateTourState>{
  List<Article> listSelectedTourPlan = [];
  CreateTourBloc() : super(CreateTourState(isPlanSet: false)) {
    on<SetTourPlan>((event,emit) {
      listSelectedTourPlan = event.tourPlan;
      emit(CreateTourState(isPlanSet: true));
      });
  }

  void removeTourPlan(int index) {
    listSelectedTourPlan.removeAt(index);
    add(SetTourPlan(tourPlan: listSelectedTourPlan));
  }
}