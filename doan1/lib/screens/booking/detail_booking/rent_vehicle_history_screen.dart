import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../BLOC/profile/profile_view/profile_bloc.dart';
import '../../../BLOC/screen/widget/vehicle_booking_item/vehicle_booking_item_bloc.dart';
import '../../detail_screens/setting_booking/checking_information_screen.dart';

class RentVehicleHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat("#,###");
    var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
    var profileBloc = context.read<ProfileBloc>();
    var vehicleBookingItemBloc = context.read<VehicleBookingItemBloc>();

    return BlocBuilder<VehicleBookingItemBloc,VehicleBookingItemState>(
      buildWhen: (previous,current) => current is VehicleBookingItemInitial,
      builder:(context,state) => Scaffold(
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider.value(
                                  value: profileBloc,
                                    child: const CheckInformationScreen())));
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
                                      vehicleBookingItemBloc.vehicle != null ?
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
                                          NetworkImage(vehicleBookingItemBloc.vehicle!=null && vehicleBookingItemBloc.vehicle!.images!.isNotEmpty ?
                                          '$baseUrl/files/${vehicleBookingItemBloc.vehicle!.images![0]}': ""),
                                          placeholder: const AssetImage('assets/images/loading.gif'),
                                          fit: BoxFit.cover,
                                        ),
                                      ):
                                      const Center(child: CircularProgressIndicator()),
                                      const SizedBox(width: 10,),
                                      vehicleBookingItemBloc.vehicle == null ?
                                      const Text('Loading...') :
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              vehicleBookingItemBloc.vehicle!.brand!,
                                              style: GoogleFonts.raleway(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 1.2,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 5,),
                                            Text(
                                              'License Plate: ${vehicleBookingItemBloc.vehicle!.licensePlate!}',
                                              style:GoogleFonts.raleway(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 1.2,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 5,),
                                            Text(
                                              'Color: ${vehicleBookingItemBloc.vehicle!.color!}',
                                              style: GoogleFonts.raleway(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 1.2,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                Text(
                                                  'Seats: ${vehicleBookingItemBloc.vehicle!.seats!}',
                                                  style: GoogleFonts.raleway(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 1.2,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(width: 5,),
                                                const Icon(Icons.airline_seat_recline_extra,size: 20,color: Colors.black,)
                                              ],
                                            ),
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
                                      const Icon(FontAwesomeIcons.car, size: 20, color: Colors.black,),
                                      const SizedBox(width: 15,),
                                      vehicleBookingItemBloc.owner != null ?
                                      Flexible(
                                        child: Text(
                                          '${vehicleBookingItemBloc.owner!.lastname} ${vehicleBookingItemBloc.owner!.firstname}\n'
                                              '${vehicleBookingItemBloc.owner!.phonenumber}\n'
                                              '${vehicleBookingItemBloc.owner!.email}',
                                          style: GoogleFonts.raleway(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.2,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ) : const Text('Loading...'),
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
                                      vehicleBookingItemBloc.vehicle != null ?
                                      Flexible(
                                        child: Text(
                                          vehicleBookingItemBloc.vehicle!.address!,
                                          style: GoogleFonts.raleway(
                                            fontSize: 18,
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
                                    vehicleBookingItemBloc.dateBooking == null ?
                                    const Text('Loading...') :
                                    Text(
                                      '${vehicleBookingItemBloc.dateBooking!.startDate!.day}'
                                          '/${vehicleBookingItemBloc.dateBooking!.startDate!.month}'
                                          '/${vehicleBookingItemBloc.dateBooking!.startDate!.year}',
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
                                    vehicleBookingItemBloc.dateBooking == null ?
                                    const Text('Loading...') :
                                    vehicleBookingItemBloc.dateBooking!.endDate!.day - vehicleBookingItemBloc.dateBooking!.startDate!.day > 1 ?
                                    Text(
                                      '${vehicleBookingItemBloc.dateBooking!.endDate!.day - vehicleBookingItemBloc.dateBooking!.startDate!.day} Days',
                                      style: GoogleFonts.raleway(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1.2,
                                        color: Colors.black,
                                      ),
                                    ) :
                                    Text(
                                      '${vehicleBookingItemBloc.dateBooking!.endDate!.day - vehicleBookingItemBloc.dateBooking!.startDate!.day} Day',
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
                                    vehicleBookingItemBloc.dateBooking == null ?
                                    const Text('Loading...') :
                                    Text(
                                      '${vehicleBookingItemBloc.dateBooking!.startDate!.day}'
                                          '/${vehicleBookingItemBloc.dateBooking!.startDate!.month}'
                                          '/${vehicleBookingItemBloc.dateBooking!.startDate!.year}',
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
                                    vehicleBookingItemBloc.dateBooking == null ?
                                    const Text('Loading...') :
                                    Text(
                                      '${vehicleBookingItemBloc.dateBooking!.endDate!.day}'
                                          '/${vehicleBookingItemBloc.dateBooking!.endDate!.month}'
                                          '/${vehicleBookingItemBloc.dateBooking!.endDate!.year}',
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
                        vehicleBookingItemBloc.dateBooking == null ?
                        const Text('Loading...') :
                        TextFormField(
                          initialValue: vehicleBookingItemBloc.dateBooking!.note,
                          readOnly: true,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText:vehicleBookingItemBloc.dateBooking!.note!.isEmpty ? 'No note' : '${vehicleBookingItemBloc.dateBooking!.note}',
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
                        const SizedBox(height: 10,),
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
                                vehicleBookingItemBloc.vehicle == null ?
                                "Loading..." :
                                "${formatCurrency.format(vehicleBookingItemBloc.vehicle!.pricePerDay)} VNĐ",
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
                                vehicleBookingItemBloc.vehicle == null ?
                                "Loading..." :
                                "${formatCurrency.format(vehicleBookingItemBloc.vehicle!.pricePerDay!*0.1)} VNĐ",
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
                                vehicleBookingItemBloc.vehicle == null ?
                                "Loading..." :
                                "${formatCurrency.format(vehicleBookingItemBloc.vehicle!.pricePerDay!*1.1)} VNĐ",
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
                                fontWeight: FontWeight.w600,
                              ),),
                          ),
                        ),
                        const SizedBox(height: 20,),
                      ]),
                ),
              ]),
        ),
      ),
    );
  }

}