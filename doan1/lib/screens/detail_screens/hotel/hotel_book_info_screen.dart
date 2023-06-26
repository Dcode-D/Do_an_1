import 'package:doan1/BLOC/hotel_booking/hotel_booking_bloc.dart';
import 'package:doan1/BLOC/screen/book_history/book_history_bloc.dart';
import 'package:doan1/BLOC/widget_item/hotel_item/hotel_item_bloc.dart';
import 'package:doan1/screens/detail_screens/setting_booking/checking_information_screen.dart';
import 'package:doan1/screens/detail_screens/setting_booking/date_setting_dialog.dart';
import 'package:doan1/screens/detail_screens/setting_booking/room_setting_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../BLOC/profile/profile_view/profile_bloc.dart';
import 'hotel_booking_success.dart';


class HotelBookingInfoScreen extends StatelessWidget{
  const HotelBookingInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateRangePickerController dateRangePickerController = DateRangePickerController();

    var profileBloc = context.read<ProfileBloc>();
    var hotelItemBloc = context.read<HotelItemBloc>();
    var hotelBookingBloc = context.read<HotelBookingBloc>();
    var bookHistoryBloc = context.read<BookHistoryBloc>();
    final formatCurrency = NumberFormat("#,###");
    final today = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day
    );
    TextEditingController noteController = TextEditingController();

    setDate() =>{
      hotelBookingBloc.add(SetBookingDate()),
      Navigator.pop(context),
    };

    double calculateTotalPrice() {
      double totalPrice = 0;
      for (var i = 0; i < hotelBookingBloc.listSelectedHotelRoom.length; i++) {
        totalPrice += hotelBookingBloc.listSelectedHotelRoom[i].price!;
      }
      return totalPrice;
    }

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<HotelBookingBloc,HotelBookingState>(
          builder: (context,state) =>
              BlocListener<HotelBookingBloc,HotelBookingState>(
                listener: (context,state){
                  if(state.isBookingSuccess == BookingState.success){
                    bookHistoryBloc.add(GetBookingHistory());
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HotelBookingSuccessScreen()));
                  }
                  else if (state.isBookingSuccess == BookingState.failure){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Booking Failed'),
                        content: const Text('Please check your booking information again'),
                        actions: [
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Text(
                        'Booking Info',
                        style: GoogleFonts.raleway(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                BlocProvider<ProfileBloc>.value(
                                  value: profileBloc,
                                  child: const CheckInformationScreen())
                                  )
                                );
                              },
                              child: Row(
                                children: [
                                  const Icon(FontAwesomeIcons.user, size: 20, color: Colors.black,),
                                  const SizedBox(width: 15,),
                                  Text(
                                      'Check',
                                      style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: GoogleFonts.raleway().fontFamily,
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
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(FontAwesomeIcons.bed, color: Colors.black, size: 20,),
                                    const SizedBox(width: 15,),
                                    Text(
                                      hotelItemBloc.hotel!.name!,
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
                                    Flexible(
                                      child: Text(
                                        hotelItemBloc.hotel!.address!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: GoogleFonts.raleway().fontFamily,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.2,
                                          color: Colors.black,
                                        ),
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
                          children:[
                            Text(
                              'Checkin & Checkout',
                              style: GoogleFonts.raleway(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                                onTap: (){
                                  showGeneralDialog(context: context,
                                    barrierDismissible: true,
                                    barrierLabel:
                                    MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                    barrierColor: Colors.black54,
                                    pageBuilder: (context, anim1, anim2) =>
                                        DateSettingDialog(
                                            setBookingDate:setDate,
                                            dateRangePickerController:dateRangePickerController),);
                                },
                                child: Text(
                                  'Set a date',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: GoogleFonts.raleway().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.2,
                                    color: Colors.orange,
                                  ),
                                )
                            )
                          ]
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
                                    Text(
                                      dateRangePickerController.selectedRange == null
                                          ? "Select Date"
                                          :
                                      dateRangePickerController.selectedRange!.startDate == null
                                          ? "Select Date"
                                          :
                                      DateFormat('dd/MM/yyyy').format(dateRangePickerController.selectedRange!.startDate!),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: GoogleFonts.raleway().fontFamily,
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
                                    Text(
                                      dateRangePickerController.selectedRange == null
                                          ? "Select Date"
                                          :
                                      dateRangePickerController.selectedRange!.endDate == null
                                          ? "Select Date"
                                          :
                                      DateFormat('dd/MM/yyyy').format(dateRangePickerController.selectedRange!.endDate!),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: GoogleFonts.raleway().fontFamily,
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
                              'Room',
                              style: GoogleFonts.raleway(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: (){
                                dateRangePickerController.selectedRange == null || dateRangePickerController.selectedRange!.startDate == null || dateRangePickerController.selectedRange!.endDate == null
                                    ?
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Warning'),
                                      content: const Text('You need to set a date first'),
                                      actions: [
                                        TextButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),)
                                    :
                                showGeneralDialog(context: context,
                                  barrierDismissible: true,
                                  barrierLabel:
                                  MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                  barrierColor: Colors.black54,
                                    pageBuilder: (context, anim1, anim2) =>
                                          MultiBlocProvider(
                                            providers: [
                                                BlocProvider.value(value: hotelItemBloc..add(
                                                    GetHotelRoomEvent(
                                                      startDate: dateRangePickerController.selectedRange!.startDate.toString().substring(0,10),
                                                      endDate: dateRangePickerController.selectedRange!.endDate.toString().substring(0,10),
                                                    ))),
                                                BlocProvider.value(value: hotelBookingBloc),
                                              ],
                                            child: RoomSettingDialog(),
                                      ),
                                );
                              },
                              child: Text(
                                'Set',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: GoogleFonts.raleway().fontFamily,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                  color: Colors.orange,
                                ),
                              )
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        hotelBookingBloc.listSelectedHotelRoom.isEmpty ?
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
                            child: Text(
                              'Select Room',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: GoogleFonts.raleway().fontFamily,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ) :
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: hotelBookingBloc.listSelectedHotelRoom.length,
                              itemBuilder: (context,index){
                                return Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Room ${hotelBookingBloc.listSelectedHotelRoom[index].number}',
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
                                            'Price: ${formatCurrency.format(hotelBookingBloc.listSelectedHotelRoom[index].price)} VNĐ / night',
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
                                            'Adult capacity: ${hotelBookingBloc.listSelectedHotelRoom[index].adultCapacity}',
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
                                            'Child capacity: ${hotelBookingBloc.listSelectedHotelRoom[index].childrenCapacity}',
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
                                                hotelBookingBloc.listSelectedHotelRoom[index].checkInHour == null ? 'No check in' :

                                                    hotelBookingBloc.listSelectedHotelRoom[index].checkInHour! < 10
                                                        && hotelBookingBloc.listSelectedHotelRoom[index].checkInMinute! < 10?
                                                        'Check in: 0${hotelBookingBloc.listSelectedHotelRoom[index].checkInHour!}'
                                                        ':0${hotelBookingBloc.listSelectedHotelRoom[index].checkInMinute!}' :

                                                    hotelBookingBloc.listSelectedHotelRoom[index].checkInHour! < 10
                                                        && hotelBookingBloc.listSelectedHotelRoom[index].checkInMinute! >= 10 ?
                                                        'Check in: 0${hotelBookingBloc.listSelectedHotelRoom[index].checkInHour!}'
                                                        ':${hotelBookingBloc.listSelectedHotelRoom[index].checkInMinute!}' :

                                                    hotelBookingBloc.listSelectedHotelRoom[index].checkInHour! >= 10
                                                        && hotelBookingBloc.listSelectedHotelRoom[index].checkInMinute! < 10 ?
                                                        'Check in: ${hotelBookingBloc.listSelectedHotelRoom[index].checkInHour!}'
                                                        ':0${hotelBookingBloc.listSelectedHotelRoom[index].checkInMinute!}' :

                                                'Check in: ${hotelBookingBloc.listSelectedHotelRoom[index].checkInHour!}'
                                                    ':${hotelBookingBloc.listSelectedHotelRoom[index].checkInMinute!}',
                                                style: GoogleFonts.raleway(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                hotelBookingBloc.listSelectedHotelRoom[index].checkOutHour == null ? 'No check out' :

                                                      hotelBookingBloc.listSelectedHotelRoom[index].checkOutHour! < 10
                                                          && hotelBookingBloc.listSelectedHotelRoom[index].checkOutMinute! < 10?
                                                          'Check out: 0${hotelBookingBloc.listSelectedHotelRoom[index].checkOutHour!}'
                                                          ':0${hotelBookingBloc.listSelectedHotelRoom[index].checkOutMinute!}' :

                                                      hotelBookingBloc.listSelectedHotelRoom[index].checkOutHour! < 10
                                                          && hotelBookingBloc.listSelectedHotelRoom[index].checkOutMinute! >= 10 ?
                                                          'Check out: 0${hotelBookingBloc.listSelectedHotelRoom[index].checkOutHour!}'
                                                          ':${hotelBookingBloc.listSelectedHotelRoom[index].checkOutMinute!}' :

                                                      hotelBookingBloc.listSelectedHotelRoom[index].checkOutHour! >= 10
                                                          && hotelBookingBloc.listSelectedHotelRoom[index].checkOutMinute! < 10 ?
                                                          'Check out: ${hotelBookingBloc.listSelectedHotelRoom[index].checkOutHour!}'
                                                          ':0${hotelBookingBloc.listSelectedHotelRoom[index].checkOutMinute!}' :

                                                'Check in: ${hotelBookingBloc.listSelectedHotelRoom[index].checkOutHour!}'
                                                      ':${hotelBookingBloc.listSelectedHotelRoom[index].checkOutMinute!}',
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
                                    const SizedBox(width: 10,),
                                    InkWell(
                                      onTap: () {
                                        hotelBookingBloc.add(RemoveRoomEvent(index: index));
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                );
                              }
                           ),
                        ),
                        Text('Please don\'t pick select a date sequence like your previous booking\'s date sequence',
                          style: GoogleFonts.raleway(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 1.2,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 10,),
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
                        TextFormField(
                          controller: noteController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Enter note',
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
                        const SizedBox(height: 20,),
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
                            Text(
                              // "${widget.totalPrice} \$",
                              "${formatCurrency.format(calculateTotalPrice())} VNĐ",
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
                              Text(
                                // "${widget.totalPrice} \$",
                                "${formatCurrency.format(calculateTotalPrice()*0.1)} VNĐ",
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
                                // "${widget.totalPrice} \$",
                                "${formatCurrency.format(calculateTotalPrice()*1.1)} VNĐ",
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
                        ElevatedButton(
                          onPressed: (){
                            if (dateRangePickerController.selectedRange == null){
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Booking Failed'),
                                  content: const Text('Please select a date range'),
                                  actions: [
                                    TextButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }
                            else if (dateRangePickerController.selectedRange!.startDate!.isBefore(today)){
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Booking Failed'),
                                  content: const Text('Please select a valid date range'),
                                  actions: [
                                    TextButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }
                            else if(hotelBookingBloc.listSelectedHotelRoom.isEmpty){
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Booking Failed'),
                                  content: const Text('Please select at least one room'),
                                  actions: [
                                    TextButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }
                            else{
                              List<String> listRoomId = [];
                              for (var room in hotelBookingBloc.listSelectedHotelRoom){
                                listRoomId.add(room.id!);
                              }
                              hotelBookingBloc.add(BookingRoomEvent(
                                attachedServices: listRoomId,
                                startDate: dateRangePickerController.selectedRange!.startDate.toString().substring(0,10),
                                endDate: dateRangePickerController.selectedRange!.endDate.toString().substring(0,10),
                                user: profileBloc.user!.id,
                                note: noteController.text,
                                approved: false,
                                suspended: false,
                                type: 'hotel',
                              ));
                            }
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
                            child: Text("Confirm booking",
                              style: GoogleFonts.raleway(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              ),),
                          ),
                        ),
                        const SizedBox(height: 20,),
                      ]),
                    ),
              ]),
            ),
          )
        )
      ),
    );
  }

}