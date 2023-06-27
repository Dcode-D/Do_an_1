part of 'booker_bloc.dart';

@immutable
abstract class BookerEvent {}

class GetBookerEvent extends BookerEvent {
  final String ownerId;
  final int page;
  GetBookerEvent({required this.ownerId,required this.page});
}

class BookingRefreshed extends BookerEvent {

}