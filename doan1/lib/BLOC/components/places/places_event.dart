part of 'places_bloc.dart';

@immutable
abstract class PlacesEvent {}

class GetProvinceEvent extends PlacesEvent {}

class GetDistrictEvent extends PlacesEvent {
  final int provinceCode;
  GetDistrictEvent(this.provinceCode);
}
