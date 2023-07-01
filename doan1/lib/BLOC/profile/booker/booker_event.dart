part of 'booker_bloc.dart';

@immutable
abstract class BookerEvent {}

class GetBookerEvent extends BookerEvent {}


class BookingRefreshed extends BookerEvent {}