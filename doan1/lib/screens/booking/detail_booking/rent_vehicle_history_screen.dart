import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../detail_screens/hotel/setting_booking/checking_information_screen.dart';

class RentVehicleHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Detail booking item\'s name',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckInformationScreen()));
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
                      InkWell(
                        onTap: (){
                          //TODO: make navigator to detail vehicle
                        },
                        child: Container(
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image(
                                      image: AssetImage('assets/images/hotel1.jpg'),
                                      height: 100,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 5,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Vehicle 1',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: GoogleFonts.raleway().fontFamily,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.2,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                          'Vehicle description',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: GoogleFonts.raleway().fontFamily,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.2,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
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
                                    const Icon(FontAwesomeIcons.car, size: 20, color: Colors.black,),
                                    const SizedBox(width: 15,),
                                    Text(
                                      'Owner',
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
                                    Text(
                                      'Location',
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
                      ),
                      const SizedBox(height: 20,),
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
                      Row(
                          children: [
                            // Checkbox(
                            //     value: state.needDriver,
                            //     onChanged: (checked) {
                            //       context.read<VehicleRentBloc>().add(CheckNeedDriverEvent(needDriver: !state.needDriver));
                            //     }
                            // ),
                            Text(
                              'Need driver ?',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: GoogleFonts.raleway().fontFamily,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            ),
                          ]),
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