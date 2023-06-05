part of 'places_bloc.dart';

@immutable
abstract class PlacesState {}

class PlacesInitial extends PlacesState {}

class PlaceProvinceState extends PlacesState {
  final List<Map> listProvince;
  PlaceProvinceState(this.listProvince);
}

class PlaceDistrictState extends PlacesState {
  final List<Map> listDistrict;
  PlaceDistrictState(this.listDistrict);
}
