import 'package:bloc/bloc.dart';
import 'package:doan1/data/repositories/rating_repo.dart';
import 'package:doan1/data/repositories/user_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/rating.dart';
import '../../../data/model/user.dart';

part 'rating_item_event.dart';
part 'rating_item_state.dart';

class RatingItemBloc extends Bloc<RatingItemEvent,RatingItemState>{
  Rating? rating;
  User? user;
  RatingItemBloc() : super(RatingItemInitialState()){

    on<GetRatingItemEvent>((event,emit)async{
      if(event.rating == null){
        emit(GetRatingItemState(getRatingItemSuccess: false));
        return;
      }
      rating = event.rating;
      user = await getUser(rating!.user!);
      // var result = await getRatingItem(event.ratingId);
      if(rating == null || user == null){
        emit(GetRatingItemState(getRatingItemSuccess: false));
        return;
      }
      emit(GetRatingItemState(getRatingItemSuccess: true));
    });
  }

  Future<User?> getUser(String userId)async{
    var userRepo = GetIt.instance<UserRepository>();
    return await userRepo.getUserById(userId);
  }
}