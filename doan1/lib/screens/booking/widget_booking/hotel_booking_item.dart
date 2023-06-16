import 'package:dio/dio.dart';
import 'package:doan1/models/hotel_model.dart';
import 'package:doan1/screens/booking/detail_booking/booking_hotel_history_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../BLOC/profile/profile_view/profile_bloc.dart';
import '../../../BLOC/screen/widget/hotel_booking_item/hotel_booking_item_bloc.dart';

class HotelBookingItem extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    var profileBloc = context.read<ProfileBloc>();
    var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
    var hotelBookingItemBloc = context.read<HotelBookingItemBloc>();
    final formatCurrency = NumberFormat("#,###");
    int calculateTotalPrice() {
      int totalPrice = 0;
      for (var i = 0; i < hotelBookingItemBloc.lsHotelRoom!.length; i++) {
        totalPrice += hotelBookingItemBloc.lsHotelRoom![i].price!;
      }
      return totalPrice;
    }

    return BlocBuilder<HotelBookingItemBloc,HotelBookingItemState>(
      buildWhen: (previous, current) => current is HotelBookingItemInitial,
      builder: (context,state) =>
        Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 5,
              ),],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.hotel, size: 25,),
                    const SizedBox(width: 10,),
                    Text('Hotel',
                      style: GoogleFonts.raleway(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold
                      ),),
                    const Spacer(),
                    hotelBookingItemBloc.dateBooking == null ? const Text('Loading...') :
                    Text(
                      '${hotelBookingItemBloc.dateBooking!.startDate!.day}/${hotelBookingItemBloc.dateBooking!.startDate!.month}/${hotelBookingItemBloc.dateBooking!.startDate!.year}',
                      style: GoogleFonts.raleway(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    hotelBookingItemBloc.hotel != null ?
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child:
                      FadeInImage(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.325,
                        imageErrorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.325,
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: const Center(child: Icon(Icons.error)));
                        },
                        image:
                        NetworkImage(hotelBookingItemBloc.hotel!=null && hotelBookingItemBloc.hotel!.images!.isNotEmpty ?
                        '$baseUrl/files/${hotelBookingItemBloc.hotel!.images![0]}': ""),
                        placeholder: const AssetImage('assets/images/loading.gif'),
                        fit: BoxFit.cover,
                      ),
                    ):
                    const Center(child: CircularProgressIndicator()),
                    const SizedBox(width: 10,),
                    hotelBookingItemBloc.hotel == null ? const Text('Loading...') :
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(hotelBookingItemBloc.hotel!.name!,
                          style: GoogleFonts.raleway(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54
                          ),),
                        const SizedBox(height: 5,),
                        Text(hotelBookingItemBloc.hotel!.address!,
                          style: GoogleFonts.raleway(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54
                          ),),
                      ],)
                  ],
                ),
                const SizedBox(height: 10,),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black12,
                ),
                const SizedBox(height: 10,),
                Row(
                    children:[
                    hotelBookingItemBloc.dateBooking == null ?
                    const Text('Loading...') :
                    hotelBookingItemBloc.dateBooking!.approved == false ?
                      Text(
                        'Status: Pending',
                        style: GoogleFonts.raleway(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54
                        ),
                      ) : Text(
                        'Status: Approved',
                        style: GoogleFonts.raleway(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54
                        ),
                      ),
                      const Spacer(),
                      hotelBookingItemBloc.lsHotelRoom != null ?
                      Text(
                        'Total: ${formatCurrency.format(calculateTotalPrice()*1.1)} VNĐ',
                        style: GoogleFonts.raleway(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54
                        )
                      ) : const Text('Loading...'),
                    ]
                ),
                Row(
                  children: [
                    hotelBookingItemBloc.dateBooking == null ? const Text('Loading...') :
                    hotelBookingItemBloc.dateBooking!.note!.length >= 20 ?
                    Text(
                      'Note: ${hotelBookingItemBloc.dateBooking!.note!.substring(0,20)}...',
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic
                      ),
                    ) :
                    Text(
                      'Note: ${hotelBookingItemBloc.dateBooking!.note!}',
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookingHotelHistoryScreen()));
                        },
                        child:
                        Text(
                          'Detail',
                          style: GoogleFonts.raleway(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}