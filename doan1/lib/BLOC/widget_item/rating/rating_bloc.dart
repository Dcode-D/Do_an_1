import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/rating.dart';
import '../../../data/repositories/rating_repo.dart';

part 'rating_event.dart';
part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent,RatingState> {
  List<Rating>? listRating;
  double? ratingByCustomer;
  int? FiveStarRatingList;
  int? FourStarRatingList;
  int? ThreeStarRatingList;
  int? TwoStarRatingList;
  int? OneStarRatingList;

  RatingBloc() : super(InitialRatingState()){
    on<GetRatingListEvent>((event,emit) async {
      if(event.serviceId == null && event.type == null){
        emit(GetRatingListState(getRatingSuccess: false));
        return;
      }
      listRating = await getListRating(event.page,event.serviceId!);
      ratingByCustomer = await getGeneralRating(event.type,event.serviceId!);

      FiveStarRatingList = await getListRatingByRatingScale(event.page,event.serviceId!,5);
      FourStarRatingList = await getListRatingByRatingScale(event.page,event.serviceId!,4);
      ThreeStarRatingList = await getListRatingByRatingScale(event.page,event.serviceId!,3);
      TwoStarRatingList = await getListRatingByRatingScale(event.page,event.serviceId!,2);
      OneStarRatingList = await getListRatingByRatingScale(event.page,event.serviceId!,1);

      if(listRating == null || ratingByCustomer == null){
        emit(GetRatingListState(getRatingSuccess: false));
        return;
      }
      emit(GetRatingListState(getRatingSuccess: true));
    });

    on<CreateRatingEvent>((event,emit)async{
      if(event.serviceId == null && event.userId == null && event.content == null && event.rating == null && event.type == null){
        emit(CreateRatingState(createRatingSuccess: false));
        return;
      }
      var result = await createRating(event.serviceId, event.userId, event.content, event.rating, event.type);
      if(result == false){
        emit(CreateRatingState(createRatingSuccess: false));
        return;
      }
      emit(CreateRatingState(createRatingSuccess: true));
    });

    on<DeleteRatingEvent>((event,emit)async{
      if(event.ratingId == null){
        emit(DeleteRatingState(deleteRatingSuccess: false));
        return;
      }
      var result = await deleteRating(event.ratingId);
      listRating!.removeAt(event.index!);
      if(result == false){
        emit(DeleteRatingState(deleteRatingSuccess: false));
        return;
      }
      emit(DeleteRatingState(deleteRatingSuccess: true));
    });

    on<UpdateRatingEvent>((event,emit)async{
      if(event.ratingId == null && event.content == null && event.rating == null){
        emit(UpdateRatingState(updateRatingSuccess: false));
        return;
      }
      var result = await updateRating(event.ratingId, event.content, event.rating);
      if(result == false){
        emit(UpdateRatingState(updateRatingSuccess: false));
        return;
      }
      emit(UpdateRatingState(updateRatingSuccess: true));
    });
  }


  Future<List<Rating>?> getListRating(int page,String serviceId) async {
    var ratingRepo = GetIt.instance.get<RatingRepository>();
    try{
      var result = await ratingRepo.getListRating(page,serviceId,null,null);
      return result;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<int?> getListRatingByRatingScale(int page,String serviceID,double ratingScale) async {
    var ratingRepo = GetIt.instance.get<RatingRepository>();
    try{
      var result = await ratingRepo.getListRating(page,serviceID,null,ratingScale);
      if (result == null) {
        return 0;
      }
      return result.length.toInt();
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<bool> createRating(String serviceId,String userId,String content,double rating,String type) async {
    var ratingRepo = GetIt.instance.get<RatingRepository>();
    try{
      var result = await ratingRepo.createRating(userId, serviceId, rating, content,type);
      return result;
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> deleteRating(String ratingId) async {
    var ratingRepo = GetIt.instance.get<RatingRepository>();
    try{
      var result = await ratingRepo.deleteRating(ratingId);
      return result;
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> updateRating(String ratingId,String content,double rating) async {
    var ratingRepo = GetIt.instance.get<RatingRepository>();
    try{
      var result = await ratingRepo.updateRating(ratingId, rating, content);
      return result;
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<double?> getGeneralRating(String type,String serviceId) async {
    var ratingRepo = GetIt.instance.get<RatingRepository>();
    try{
      var result = await ratingRepo.getGeneralRating(type,serviceId);
      return result;
    }catch(e){
      print(e);
      return null;
    }
  }
}

