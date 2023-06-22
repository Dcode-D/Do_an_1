import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/datebooking.dart';
import '../../../data/model/user.dart';
import '../../../data/repositories/datebooking_repo.dart';
import '../../../data/repositories/user_repo.dart';

part 'book_history_event.dart';
part 'book_history_state.dart';

class BookHistoryBloc extends Bloc<BookHistoryEvent,BookHistoryState>{
  List<DateBooking>? lsHotelBooking = [];
  List<DateBooking>? lsVehicleBooking = [];
  User? user;
  BookHistoryBloc() : super(BookHistoryInitial(isBookingHistoryLoaded: false)) {
    on<GetBookingHistory>((event,emit) async {
      lsHotelBooking!.clear();
      lsVehicleBooking!.clear();
      user = await getUser();
      List<DateBooking>? tempLs = await getHotelBooking(user!.id,1);
      if(tempLs != null){
        for(int i = 0;i<tempLs.length;i++){
          if(tempLs[i].type == "hotel"){
            lsHotelBooking!.add(tempLs[i]);
          }
          else{
            lsVehicleBooking!.add(tempLs[i]);
          }
        }
        emit(BookHistoryInitial(isBookingHistoryLoaded: true));
      }
      else{
        emit(BookHistoryInitial(isBookingHistoryLoaded: false));
      }
    });
  }
  Future<List<DateBooking>?> getHotelBooking(String userID,int page) async {
    DateBookingRepository dateBookingRepo = GetIt.instance.get<DateBookingRepository>();
    try{
      var result = await dateBookingRepo.GetBookingDate(userID,page);
      return result;
    }catch(e){
      print(e);
      return null;
    }
  }
  Future<User?> getUser() async {
    var userRepo = GetIt.instance.get<UserRepository>();
    try {
      user = await userRepo.getUser();
      return user;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}