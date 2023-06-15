part of 'book_history_bloc.dart';

@immutable
abstract class BookHistoryEvent {}

class GetBookingHistory extends BookHistoryEvent{}