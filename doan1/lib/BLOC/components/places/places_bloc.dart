import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../Utils/get_places.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  PlacesBloc() : super(PlacesInitial()) {
    on<PlacesEvent>((event, emit) {
    });
    on<GetProvinceEvent>((event, emit) async {
      var listProvince = await GetPlaces.getProvince();
      emit(PlaceProvinceState(listProvince));
    });
    on<GetDistrictEvent>((event, emit) async {
      var listDistrict = await GetPlaces.getDistrict(event.provinceCode);
      emit(PlaceDistrictState(listDistrict));
    });
  }
}
