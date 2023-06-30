import 'package:bloc/bloc.dart';
import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../EventBus/Events/NeedRefreshBookHistoryEvent.dart';
import '../../../data/model/datebooking.dart';
import '../../../data/model/user.dart';
import '../../../data/repositories/datebooking_repo.dart';
import '../../../data/repositories/user_repo.dart';

part 'book_history_event.dart';
part 'book_history_state.dart';

class BookHistoryBloc extends Bloc<BookHistoryEvent,BookHistoryState>{
  List<DateBooking> lsHotelBooking = [];
  List<DateBooking> lsVehicleBooking = [];
  int hotelPage =0, vehiclePage = 0;
  User? user;
  BookHistoryBloc() : super(BookHistoryInitial(isBookingHistoryLoaded: false)) {
    final eventbus = GetIt.instance.get<EventBus>();
    if(eventbus != null){
      eventbus.on<NeedRefreshBookHistoryEvent>().listen((event) {
          add(RefreshBookingHistoryEvent());
      });
    }
    on<GetNextHotelBooking>(
        (event, emit) async{
          user = await getUser();
          if(user != null){
            hotelPage ++;
            final lshotel = await getHotelBooking(user!.id, hotelPage, "hotel");
            if(lshotel != null) {
              lsHotelBooking.addAll(lshotel);
            }
            emit(BookHistoryInitial(isBookingHistoryLoaded: true));
            return;
          }
          emit(BookHistoryInitial(isBookingHistoryLoaded: false));
        }
    );
    on<GetNextVehicleBooking>(
        (event, emit) async{
          user = await getUser();
          if(user != null){
            vehiclePage ++;
            final lsvehicle = await getHotelBooking(user!.id, vehiclePage, "car");
            if(lsvehicle != null){
              lsVehicleBooking.addAll(lsvehicle);
            }
            emit(BookHistoryInitial(isBookingHistoryLoaded: true));
            return;
          }
          emit(BookHistoryInitial(isBookingHistoryLoaded: false));
        }
    );
    on<RefreshBookingHistoryEvent>(
        (event, emit) async{
          lsHotelBooking = [];
          lsVehicleBooking = [];
          final user = await getUser();
          if(user != null){
            for(var i=1; i<= hotelPage; i++){
              final lshotel = await getHotelBooking(user.id, i, "hotel");
              if(lshotel != null) {
                lsHotelBooking.addAll(lshotel);
              }
            }
            for(var i=1; i<= vehiclePage; i++){
              final lsvehicle = await getHotelBooking(user.id, i, "car");
              if(lsvehicle != null){
                lsVehicleBooking.addAll(lsvehicle);
              }
            }
            emit(BookHistoryInitial(isBookingHistoryLoaded: true));
          }
          else{
            emit(BookHistoryInitial(isBookingHistoryLoaded: false));
          }
        }
    );
  }
  Future<List<DateBooking>?> getHotelBooking(String userID,int page, type) async {
    DateBookingRepository dateBookingRepo = GetIt.instance.get<DateBookingRepository>();
    try{
      var result = await dateBookingRepo.GetBookingDate(userID,page, type);
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