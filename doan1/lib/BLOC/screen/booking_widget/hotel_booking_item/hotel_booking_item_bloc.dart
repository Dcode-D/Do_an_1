import 'package:doan1/data/repositories/hotel_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../../../../data/model/datebooking.dart';
import '../../../../data/model/hotel.dart';
import '../../../../data/model/hotelroom.dart';
import '../../../../data/model/user.dart';
import '../../../../data/repositories/datebooking_repo.dart';
import '../../../../data/repositories/hotelroom_repo.dart';
import '../../../../data/repositories/user_repo.dart';

part 'hotel_booking_item_event.dart';
part 'hotel_booking_item_state.dart';

class HotelBookingItemBloc extends Bloc<HotelBookingItemEvent,HotelBookingItemState> {
  DateBooking? dateBooking;
  List<HotelRoom>? lsHotelRoom;
  Hotel? hotel;
  User? user;
  int? index;
  HotelBookingItemBloc() : super(HotelBookingItemInitial(getDataSuccess: false)) {
    on<HotelBookingItemInitialEvent>((event,emit) async {
      lsHotelRoom = [];
      user = await getUserFunc(event.dateBooking!.user!);
      index = event.index;
      dateBooking = event.dateBooking;
      for (String room in event.dateBooking!.attachedServices!) {
        lsHotelRoom!.add(await getHotelRoomFunc(room) as HotelRoom);
      }
      hotel = await getHotelFunc(lsHotelRoom![0].hotel!);
      if(hotel != null && lsHotelRoom != null){
        emit(HotelBookingItemInitial(getDataSuccess: true));
      }
      else{
        emit(HotelBookingItemInitial(getDataSuccess: false));
      }
    });
    on<HotelBookingItemRejectEvent>((event,emit) async{
      bool? rejectSuccess = await rejectDateBookingFunc(dateBooking!.id!);
      if(rejectSuccess == true){
        emit(HotelBookingItemRejectSuccess(rejectSuccess: true));
      }
      else{
        emit(HotelBookingItemRejectSuccess(rejectSuccess: false));
      }
    });
    on<HotelBookingItemDeleteEvent>((event,emit)async{
      bool? deleteSuccess = await deleteDateBookingFunc(dateBooking!.id!);
      if(deleteSuccess == true){
        emit(HotelBookingItemDeleteSuccess(deleteSuccess: true));
      }
      else{
        emit(HotelBookingItemDeleteSuccess(deleteSuccess: false));
      }
    });
    on<HotelBookingItemApproveEvent>((event,emit)async{
      bool? approveSuccess = await approveDateBookingFunc(dateBooking!.id!);
      if(approveSuccess == true){
        emit(HotelBookingItemApproveSuccess(approveSuccess: true));
      }
      else{
        emit(HotelBookingItemApproveSuccess(approveSuccess: false));
      }
    });

    on<HotelBookingItemRefreshEvent>((event,emit)async{
      if(dateBooking == null){
        emit(HotelBookingItemInitial(getDataSuccess: false));
      }
      dateBooking = await getDateBookingFunc(dateBooking!.id!);
      lsHotelRoom = [];
      for (String room in dateBooking!.attachedServices!) {
        lsHotelRoom!.add(await getHotelRoomFunc(room) as HotelRoom);
      }
      hotel = await getHotelFunc(lsHotelRoom![0].hotel!);
      if(hotel != null && lsHotelRoom != null){
        emit(HotelBookingItemInitial(getDataSuccess: true));
      }
      else{
        emit(HotelBookingItemInitial(getDataSuccess: false));
      }
    });
  }

  Future<HotelRoom?> getHotelRoomFunc(String hotelRoomId) async{
    return GetIt.instance<HotelRoomRepository>().getHotelRoomById(hotelRoomId).then((value) {
      if(value != null){
        return value;
      }
      else{
        return null;
      }
    });
  }

  Future<Hotel?> getHotelFunc(String hotelId) async{
    var hotelRepo = GetIt.instance<HotelRepository>();
    try{
      hotel = await hotelRepo.getHotelById(hotelId);
      return hotel;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future<bool?> rejectDateBookingFunc(String dateBookingId) async{
    return GetIt.instance<DateBookingRepository>().RejectBookingDate(dateBookingId);
  }

  Future<bool?> deleteDateBookingFunc(String dateBookingId) async{
    return GetIt.instance<DateBookingRepository>().DeleteBookingDate(dateBookingId);
  }

  Future<bool?> approveDateBookingFunc(String dateBookingId) async{
    return GetIt.instance<DateBookingRepository>().ApproveBookingDate(dateBookingId);
  }

  Future<User?> getUserFunc(String userId) async{
    return GetIt.instance<UserRepository>().getUserById(userId);
  }

  Future<DateBooking?> getDateBookingFunc(String dateBookingId) async{
    return GetIt.instance<DateBookingRepository>().GetDateBookingById(dateBookingId);
  }
}