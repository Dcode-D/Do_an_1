part of 'rating_bloc.dart';

@immutable
abstract class RatingState{}

class InitialRatingState extends RatingState{}

class GetRatingListState extends RatingState {
  bool getRatingSuccess;
  GetRatingListState({required this.getRatingSuccess});
}

class CreateRatingState extends RatingState{
  bool createRatingSuccess;
  CreateRatingState({required this.createRatingSuccess});
}

class DeleteRatingState extends RatingState{
  bool deleteRatingSuccess;
  DeleteRatingState({required this.deleteRatingSuccess});
}

class UpdateRatingState extends RatingState{
  bool updateRatingSuccess;
  UpdateRatingState({required this.updateRatingSuccess});
}