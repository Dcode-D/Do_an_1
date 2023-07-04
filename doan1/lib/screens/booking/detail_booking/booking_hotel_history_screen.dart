import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../BLOC/profile/profile_view/profile_bloc.dart';
import '../../../BLOC/screen/book_history/book_history_bloc.dart';
import '../../../BLOC/screen/booking_widget/hotel_booking_item/hotel_booking_item_bloc.dart';
import '../../detail_screens/setting_booking/checking_information_screen.dart';

class BookingHotelHistoryScreen extends StatelessWidget {
  const BookingHotelHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat("#,###");
    var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
    var profileBloc = context.read<ProfileBloc>();
    var hotelBookingItemBloc = context.read<HotelBookingItemBloc>();

    return BlocListener<HotelBookingItemBloc,HotelBookingItemState>(
      listenWhen: (previous, current) =>
      current is HotelBookingItemRejectSuccess ||
          current is HotelBookingItemDeleteSuccess,
      listener: (context,state){
        if(state is HotelBookingItemDeleteSuccess){
          if(state.deleteSuccess == true){
            showDialog(context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Booking'),
                  content: const Text('Delete Booking Success'),
                  actions: [
                    TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('OK')
                    )
                  ],
                ));
          }
        }
      },
      child: BlocBuilder<HotelBookingItemBloc,HotelBookingItemState>(
        buildWhen: (previous, current) =>
        current is HotelBookingItemInitial ||
            current is HotelBookingItemRejectSuccess,
        builder: (context,state) => SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
              title: Text(
                'Booking Information',
                style: GoogleFonts.raleway(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600
                )
              ),
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Information',
                        style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black.withOpacity(0.2),
                              width:1),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider.value(
                                value: profileBloc,
                                  child: CheckInformationScreen())));
                            },
                            child: Row(
                              children: [
                                const Icon(FontAwesomeIcons.user, size: 20, color: Colors.black,),
                                const SizedBox(width: 15,),
                                Text(
                                  'Check',
                                  style: GoogleFonts.raleway(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1.2,
                                    color: Colors.black,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(FontAwesomeIcons.arrowRight,
                                  size: 20,
                                  color: Colors.black,),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Text(
                        'Hotel',
                        style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black.withOpacity(0.2),
                              width:1),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  hotelBookingItemBloc.hotel != null ?
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child:
                                    FadeInImage(
                                      height: 100,
                                      width: 150,
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
                                  const SizedBox(width: 5,),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        hotelBookingItemBloc.hotel != null ?
                                        Text(
                                          hotelBookingItemBloc.hotel!.name!,
                                          style:  GoogleFonts.raleway(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.2,
                                            color: Colors.black,
                                          ),
                                        ) : const Text('Loading...'),
                                        const SizedBox(height: 5,),
                                        hotelBookingItemBloc.hotel != null ?
                                        Text(
                                          hotelBookingItemBloc.hotel!.description!,
                                          style: GoogleFonts.raleway(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.2,
                                            color: Colors.black,
                                          ),
                                        ) : const Text('Loading...'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                height:1,
                                width: double.infinity,
                                color: Colors.black.withOpacity(0.2),
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  const Icon(FontAwesomeIcons.mapLocationDot, size: 20, color: Colors.black,),
                                  const SizedBox(width: 15,),
                                  hotelBookingItemBloc.hotel != null ?
                                  Flexible(
                                    child: Text(
                                      hotelBookingItemBloc.hotel!.address!,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: GoogleFonts.raleway().fontFamily,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1.2,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ) : const Text('Loading...'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Text(
                        'Date',
                        style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black.withOpacity(0.2),
                              width:1),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(FontAwesomeIcons.calendar, size: 20, color: Colors.black,),
                                  const SizedBox(width: 15,),
                                  hotelBookingItemBloc.dateBooking == null ?
                                  const Text('Loading...') :
                                  Text(
                                    '${hotelBookingItemBloc.dateBooking!.startDate!.day}'
                                        '/${hotelBookingItemBloc.dateBooking!.startDate!.month}'
                                        '/${hotelBookingItemBloc.dateBooking!.startDate!.year}',
                                    style: GoogleFonts.raleway(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.2,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15,),
                              Container(
                                height:1,
                                width: double.infinity,
                                color: Colors.black.withOpacity(0.2),
                              ),
                              const SizedBox(height: 15,),
                              Row(
                                children: [
                                  const Icon(FontAwesomeIcons.clock, size: 20, color: Colors.black,),
                                  const SizedBox(width: 15,),
                                  hotelBookingItemBloc.dateBooking == null ?
                                  const Text('Loading...') :
                                  hotelBookingItemBloc.dateBooking!.endDate!.day - hotelBookingItemBloc.dateBooking!.startDate!.day > 1 ?
                                  Text(
                                    '${hotelBookingItemBloc.dateBooking!.endDate!.day - hotelBookingItemBloc.dateBooking!.startDate!.day} Days',
                                    style: GoogleFonts.raleway(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.2,
                                      color: Colors.black,
                                    ),
                                  ) :
                                  Text(
                                    '${hotelBookingItemBloc.dateBooking!.endDate!.day - hotelBookingItemBloc.dateBooking!.startDate!.day} Day',
                                    style: GoogleFonts.raleway(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.2,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Text(
                        'Checkin & Checkout',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: GoogleFonts.raleway().fontFamily,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black.withOpacity(0.2),
                              width:1),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(FontAwesomeIcons.arrowRight, size: 20, color: Colors.green,),
                                  const SizedBox(width: 15,),
                                  hotelBookingItemBloc.dateBooking == null ?
                                  const Text('Loading...') :
                                  Text(
                                    '${hotelBookingItemBloc.dateBooking!.startDate!.day}'
                                        '/${hotelBookingItemBloc.dateBooking!.startDate!.month}'
                                        '/${hotelBookingItemBloc.dateBooking!.startDate!.year}',
                                    style: GoogleFonts.raleway(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.2,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15,),
                              Container(
                                height:1,
                                width: double.infinity,
                                color: Colors.black.withOpacity(0.2),
                              ),
                              const SizedBox(height: 15,),
                              Row(
                                children: [
                                  const Icon(FontAwesomeIcons.arrowLeft, size: 20, color: Colors.red,),
                                  const SizedBox(width: 15,),
                                  hotelBookingItemBloc.dateBooking == null ?
                                  const Text('Loading...') :
                                  Text(
                                    '${hotelBookingItemBloc.dateBooking!.endDate!.day}'
                                        '/${hotelBookingItemBloc.dateBooking!.endDate!.month}'
                                        '/${hotelBookingItemBloc.dateBooking!.endDate!.year}',
                                    style: GoogleFonts.raleway(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.2,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          Text(
                            'Room & quantity',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: GoogleFonts.raleway().fontFamily,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      hotelBookingItemBloc.lsHotelRoom == null ?
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black.withOpacity(0.2),
                                width:1),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 2),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: const Text('Loading...')) :
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black.withOpacity(0.2),
                              width:1),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child:
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: hotelBookingItemBloc.lsHotelRoom!.length,
                            itemBuilder: (context,index){
                              return Row(
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Room ${hotelBookingItemBloc.lsHotelRoom![index].number}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: GoogleFonts.raleway().fontFamily,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.2,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        Text(
                                          'Price: ${formatCurrency.format(hotelBookingItemBloc.lsHotelRoom![index].price)} VNĐ / night',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: GoogleFonts.raleway().fontFamily,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.2,
                                            color: Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        Text(
                                          'Adult capacity: ${hotelBookingItemBloc.lsHotelRoom![index].adultCapacity}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: GoogleFonts.raleway().fontFamily,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.2,
                                            color: Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        Text(
                                          'Child capacity: ${hotelBookingItemBloc.lsHotelRoom![index].childrenCapacity}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: GoogleFonts.raleway().fontFamily,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.2,
                                            color: Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text(
                                              hotelBookingItemBloc.lsHotelRoom![index].checkInHour == null ? 'No check in' :

                                              hotelBookingItemBloc.lsHotelRoom![index].checkInHour! < 10
                                                  && hotelBookingItemBloc.lsHotelRoom![index].checkInMinute! < 10?
                                              'Check in: 0${hotelBookingItemBloc.lsHotelRoom![index].checkInHour!}'
                                                  ':0${hotelBookingItemBloc.lsHotelRoom![index].checkInMinute!}' :

                                              hotelBookingItemBloc.lsHotelRoom![index].checkInHour! < 10
                                                  && hotelBookingItemBloc.lsHotelRoom![index].checkInMinute! >= 10 ?
                                              'Check in: 0${hotelBookingItemBloc.lsHotelRoom![index].checkInHour!}'
                                                  ':${hotelBookingItemBloc.lsHotelRoom![index].checkInMinute!}' :

                                              hotelBookingItemBloc.lsHotelRoom![index].checkInHour! >= 10
                                                  && hotelBookingItemBloc.lsHotelRoom![index].checkInMinute! < 10 ?
                                              'Check in: ${hotelBookingItemBloc.lsHotelRoom![index].checkInHour!}'
                                                  ':0${hotelBookingItemBloc.lsHotelRoom![index].checkInMinute!}' :

                                              'Check in: ${hotelBookingItemBloc.lsHotelRoom![index].checkInHour!}'
                                                  ':${hotelBookingItemBloc.lsHotelRoom![index].checkInMinute!}',
                                              style: GoogleFonts.raleway(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              hotelBookingItemBloc.lsHotelRoom![index].checkOutHour == null ? 'No check out' :

                                              hotelBookingItemBloc.lsHotelRoom![index].checkOutHour! < 10
                                                  && hotelBookingItemBloc.lsHotelRoom![index].checkOutMinute! < 10?
                                              'Check out: 0${hotelBookingItemBloc.lsHotelRoom![index].checkOutHour!}'
                                                  ':0${hotelBookingItemBloc.lsHotelRoom![index].checkOutMinute!}' :

                                              hotelBookingItemBloc.lsHotelRoom![index].checkOutHour! < 10
                                                  && hotelBookingItemBloc.lsHotelRoom![index].checkOutMinute! >= 10 ?
                                              'Check out: 0${hotelBookingItemBloc.lsHotelRoom![index].checkOutHour!}'
                                                  ':${hotelBookingItemBloc.lsHotelRoom![index].checkOutMinute!}' :

                                              hotelBookingItemBloc.lsHotelRoom![index].checkOutHour! >= 10
                                                  && hotelBookingItemBloc.lsHotelRoom![index].checkOutMinute! < 10 ?
                                              'Check out: ${hotelBookingItemBloc.lsHotelRoom![index].checkOutHour!}'
                                                  ':0${hotelBookingItemBloc.lsHotelRoom![index].checkOutMinute!}' :

                                              'Check in: ${hotelBookingItemBloc.lsHotelRoom![index].checkOutHour!}'
                                                  ':${hotelBookingItemBloc.lsHotelRoom![index].checkOutMinute!}',
                                              style: GoogleFonts.raleway(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10,),
                                        Container(
                                          height:1,
                                          width: double.infinity,
                                          color: Colors.black.withOpacity(0.2),
                                        ),
                                        const SizedBox(height: 10,),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Note',
                        style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      hotelBookingItemBloc.dateBooking == null ?
                      const Text('Loading...') :
                      TextFormField(
                        initialValue: hotelBookingItemBloc.dateBooking!.note,
                        readOnly: true,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText:hotelBookingItemBloc.dateBooking!.note!.isEmpty ? 'No note' : '${hotelBookingItemBloc.dateBooking!.note}',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        'Payment',
                        style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black.withOpacity(0.2),
                              width:1),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              const Icon(FontAwesomeIcons.creditCard, size: 20, color: Colors.black,),
                              const SizedBox(width: 15,),
                              Text(
                                'Pay at hotel',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: GoogleFonts.raleway().fontFamily,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.2,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.2),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Text(
                              "Deposit: ",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts.raleway().fontFamily,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            ),
                            hotelBookingItemBloc.dateBooking == null ?
                            const Text('Loading...') :
                            Text(
                              // "${widget.totalPrice} \$",
                              "${formatCurrency.format(hotelBookingItemBloc.dateBooking!.price!)} VNĐ",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts.raleway().fontFamily,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            ),
                          ]
                      ),
                      const SizedBox(height: 10,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Text(
                              "Tax: ",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts.raleway().fontFamily,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            ),
                            hotelBookingItemBloc.dateBooking == null ?
                            const Text('Loading...') :
                            Text(
                              // "${widget.totalPrice} \$",
                              "${formatCurrency.format(hotelBookingItemBloc.dateBooking!.price!*0.1)} VNĐ",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts.raleway().fontFamily,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            ),
                          ]
                      ),
                      const SizedBox(height: 10,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Text(
                              "Total: ",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts.raleway().fontFamily,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                                hotelBookingItemBloc.dateBooking == null ?
                                    "loading..." :
                                "${formatCurrency.format(hotelBookingItemBloc.dateBooking!.price??0*1.1)} VNĐ",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts.raleway().fontFamily,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            ),
                          ]
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.2),
                      ),
                      const SizedBox(height: 20,),
                      state is HotelBookingItemInitial ?
                        state.getDataSuccess == true ?
                            hotelBookingItemBloc.dateBooking!.approved == true ?
                              Text(
                                'Your reservation has been approved',
                                style: GoogleFonts.raleway(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                  color: Colors.green,
                                ),
                              )
                                :
                            hotelBookingItemBloc.dateBooking!.suspended == true ?
                              Column(
                              children: [
                                Text(
                                  'Your reservation has been canceled',
                                  style: GoogleFonts.raleway(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.2,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                ElevatedButton(
                                  onPressed: (){
                                    showDialog(context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text("Are you sure you want to delete your reservation?",
                                            style: GoogleFonts.raleway(
                                              fontSize: 20.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),),
                                          actions: [
                                            TextButton(
                                              onPressed: (){
                                                Navigator.pop(context);
                                              },
                                              child: Text("No",
                                                style: GoogleFonts.raleway(
                                                  fontSize: 20.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),),
                                            ),
                                            TextButton(
                                              onPressed: (){
                                                hotelBookingItemBloc.add(HotelBookingItemDeleteEvent());
                                                Navigator.pop(context);
                                              },
                                              child: Text("Yes",
                                                style: GoogleFonts.raleway(
                                                  fontSize: 20.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),),
                                            ),
                                          ],
                                        ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    minimumSize: const Size(double.infinity, 50.0),
                                    elevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        color: Colors.grey,
                                        width: 0.7,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text("Delete your reservation",
                                      style: GoogleFonts.raleway(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),),
                                  ),
                                ),
                              ],
                            )
                                :
                            ElevatedButton(
                              onPressed: (){
                                showGeneralDialog(
                                  context: context,
                                  pageBuilder:(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                                    return AlertDialog(
                                      title: Text("Are you sure you want to cancel your reservation?",
                                        style: GoogleFonts.raleway(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),),
                                      actions: [
                                        TextButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                          child: Text("No",
                                            style: GoogleFonts.raleway(
                                              fontSize: 20.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),),
                                        ),
                                        TextButton(
                                          onPressed: (){
                                            hotelBookingItemBloc.add(HotelBookingItemRejectEvent());
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: Text("Yes",
                                            style: GoogleFonts.raleway(
                                              fontSize: 20.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                minimumSize: const Size(double.infinity, 50.0),
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.7,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Center(
                                child: Text("Cancel your reservation",
                                  style: GoogleFonts.raleway(
                                    fontSize: 20.0,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),),
                              ),
                            )
                                :
                          const Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          )
                              :
                      state is HotelBookingItemRejectSuccess ?
                          state.rejectSuccess == true ?
                        Column(
                        children: [
                          Text(
                            'Your reservation has been canceled',
                            style: GoogleFonts.raleway(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 10,),
                          ElevatedButton(
                            onPressed: (){
                              showDialog(context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Are you sure you want to delete your reservation?",
                                      style: GoogleFonts.raleway(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),),
                                    actions: [
                                      TextButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: Text("No",
                                          style: GoogleFonts.raleway(
                                            fontSize: 20.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),),
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          hotelBookingItemBloc.add(HotelBookingItemDeleteEvent());
                                          Navigator.pop(context);
                                        },
                                        child: Text("Yes",
                                          style: GoogleFonts.raleway(
                                            fontSize: 20.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),),
                                      ),
                                    ],
                                  ));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              minimumSize: const Size(double.infinity, 50.0),
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.grey,
                                  width: 0.7,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Center(
                              child: Text("Delete your reservation",
                                style: GoogleFonts.raleway(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),),
                            ),
                          ),
                        ],
                      ) :
                        ElevatedButton(
                        onPressed: (){
                          showGeneralDialog(
                            context: context,
                            pageBuilder:(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                              return AlertDialog(
                                title: Text("Are you sure you want to cancel your reservation?",
                                  style: GoogleFonts.raleway(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),),
                                actions: [
                                  TextButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text("No",
                                      style: GoogleFonts.raleway(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),),
                                  ),
                                  TextButton(
                                    onPressed: (){
                                      hotelBookingItemBloc.add(HotelBookingItemRejectEvent());
                                      Navigator.pop(context);
                                    },
                                    child: Text("Yes",
                                      style: GoogleFonts.raleway(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          minimumSize: const Size(double.infinity, 50.0),
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 0.7,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Center(
                          child: Text("Cancel your reservation",
                            style: GoogleFonts.raleway(
                              fontSize: 20.0,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),),
                        ),
                      ) :
                      const Center(child: CircularProgressIndicator(),),
                      const SizedBox(height: 10,),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          minimumSize: const Size(double.infinity, 50.0),
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Center(
                          child: Text("Return to home",
                            style: GoogleFonts.raleway(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),),
                        ),
                      ),
                      const SizedBox(height: 20,),
                    ]),
              ),
            )
          ),
        ),
      ),
    );
  }
}