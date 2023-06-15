part of 'book_history_bloc.dart';

@immutable
abstract class BookHistoryState {}

class BookHistoryInitial extends BookHistoryState {
  final bool isBookingHistoryLoaded;
  BookHistoryInitial({required this.isBookingHistoryLoaded});
}
