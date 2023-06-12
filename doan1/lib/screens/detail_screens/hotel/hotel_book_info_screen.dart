import 'package:doan1/BLOC/hotel_booking/hotel_booking_bloc.dart';
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
    final formatCurrency = NumberFormat("#,###");

    setDate() =>{
      hotelBookingBloc.add(SetBookingDate()),
      Navigator.pop(context),
    };

    int calculateTotalPrice() {
      int totalPrice = 0;
      for (var i = 0; i < hotelBookingBloc.listSelectedHotelRoom.length; i++) {
        totalPrice += hotelBookingBloc.listSelectedHotelRoom[i].price!;
      }
      return totalPrice;
    }

    return Scaffold(
      body: BlocBuilder<HotelBookingBloc,HotelBookingState>(
        builder: (context,state) => SingleChildScrollView(
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
                            showGeneralDialog(context: context,
                              barrierDismissible: true,
                              barrierLabel:
                              MaterialLocalizations.of(context).modalBarrierDismissLabel,
                              barrierColor: Colors.black54,
                                pageBuilder: (context, anim1, anim2) =>
                                    BlocProvider<HotelBookingBloc>.value(
                                      value: hotelBookingBloc,
                                      child: RoomSettingDialog(
                                          hotelRoom: hotelItemBloc.listHotelRoom,
                                      ),
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
                      child:
                      hotelBookingBloc.listSelectedHotelRoom.isEmpty ?
                      Padding(
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
                      ) :
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: hotelBookingBloc.listSelectedHotelRoom.length,
                            itemBuilder: (context,index){
                              return Column(
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
                                    'Price: ${hotelBookingBloc.listSelectedHotelRoom[index].price} \$ / night',
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
                                        'Check out: ${hotelBookingBloc.listSelectedHotelRoom[index].checkOutHour!}'
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
                              );
                            }
                         )
                      ),
                    ),
                    const SizedBox(height: 20,),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HotelBookingSuccessScreen()));
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
        )
      )
    );
  }

}