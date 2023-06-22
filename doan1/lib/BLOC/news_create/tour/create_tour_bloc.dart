import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:doan1/data/repositories/tour_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/article.dart';
import '../../../data/model/hotel.dart';

part 'create_tour_event.dart';
part 'create_tour_state.dart';

class CreateTourBloc extends Bloc<CreateTourEvent,CreateTourState>{
  List<Article> listSelectedTourPlan = [];
  List<Hotel> listSelectedTourHotel = [];
  CreateTourBloc() : super(CreateTourInitial()) {
    on<SetTourPlan>((event,emit) {
      for(var i = 0; i < event.tourPlan.length; i++){
          listSelectedTourPlan.add(event.tourPlan[i]);
      }
      listSelectedTourPlan = listSelectedTourPlan.toSet().toList();
      emit(PlanSetState(isPlanSet: true));
      });
    on<RemoveTourPlan>((event,emit) {
      listSelectedTourPlan.removeWhere((element) => element.id == event.article.id);
      emit(PlanSetState(isPlanSet: true));
    });

    on<SetHotelPlan>((event,emit) {
      for(var i = 0; i < event.tourHotel.length; i++){
        listSelectedTourHotel.add(event.tourHotel[i]);
      }
      listSelectedTourHotel = listSelectedTourHotel.toSet().toList();
      emit(HotelSetState(isHotelSet: true));
    });

    on<RemoveHotelPlan>((event,emit) {
      listSelectedTourHotel.removeWhere((element) => element.id == event.hotel.id);
      emit(HotelSetState(isHotelSet: true));
    });

    on<PostTour>((event,emit) async {
      final plans = listSelectedTourPlan.map((e) => e.id as String).toList();
      final hotels = listSelectedTourHotel.map((e) => e.id as String).toList();
      final repo = GetIt.instance.get<TourRepository>();
      var result = await repo.createTour(event.name, event.description, event.rating, plans, hotels, event.duration, event.price, event.maxGroupSize);
      emit(PostTourState(isPosting: false, isSuccess: result));
    });
  }
}