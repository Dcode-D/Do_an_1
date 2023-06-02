import 'package:doan1/BLOC/profile/profile_view/profile_bloc.dart';
import 'package:doan1/screens/detail_screens/vehicle/vehicle_booking_success.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../BLOC/widget_item/car_item/car_item_bloc.dart';
import '../hotel/setting_booking/checking_information_screen.dart';

class VehicleRentBookInfoScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var profileBloc = context.read<ProfileBloc>();
    var carItemBloc = context.read<CarItemBloc>();
    return Scaffold(
      body:SingleChildScrollView(
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
                                    child: const CheckInformationScreen())));
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
                          'Vehicle',
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
                                    const Icon(FontAwesomeIcons.car, color: Colors.black, size: 20,),
                                    const SizedBox(width: 15,),
                                    Text(
                                      carItemBloc.vehicle!.brand!,
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
                                    const Icon(Icons.airline_seat_legroom_extra_sharp, size: 20, color: Colors.black,),
                                    const SizedBox(width: 15,),
                                    Text(
                                      carItemBloc.vehicle!.seats!.toString(),
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
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            Text(
                              'Date',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts.raleway().fontFamily,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                                onTap: (){
                                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DateSettingScreen()));
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(FontAwesomeIcons.calendar, size: 20, color: Colors.black,),
                                    const SizedBox(width: 15,),
                                    Text(
                                      '1/6/2023',
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
                                    Text(
                                      '2 Days',
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
                                    Text(
                                      '1/6/2023',
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
                                      '3/6/2023',
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
                              'Payment',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts.raleway().fontFamily,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                                onTap: (){

                                },
                                child: Text(
                                  'Change',
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
                                  'VCB',
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
                                "100 \$",
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
                                "100 \$",
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
                                "100 \$",
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleRentSuccess()));
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
    );
  }

}