import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:doan1/data/repositories/tour_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/article.dart';

part 'create_tour_event.dart';
part 'create_tour_state.dart';

class CreateTourBloc extends Bloc<CreateTourEvent,CreateTourState>{
  List<Article> listSelectedTourPlan = [];
  CreateTourBloc() : super(CreateTourInitial()) {
    on<SetTourPlan>((event,emit) {
      for(var i = 0; i < event.tourPlan.length; i++){
          listSelectedTourPlan.add(event.tourPlan[i]);
      }
      listSelectedTourPlan = listSelectedTourPlan.toSet().toList();
      emit(PlanSetState(isPlanSet: true));
      });
    on<RemoveTourPlan>((event,emit) {
      listSelectedTourPlan.remove(event.article);
      emit(PlanSetState(isPlanSet: true));
    });
    on<PostTour>((event,emit) async {
      final  plans = listSelectedTourPlan.map((e) => e.id as String).toList();
      final repo = GetIt.instance.get<TourRepository>();
      var result = await repo.createTour(event.name, event.description, event.rating, plans, event.duration, event.price, event.maxGroupSize);
      emit(PostTourState(isPosting: false, isSuccess: result));
    });
  }
}