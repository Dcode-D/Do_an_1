import 'package:dio/dio.dart';
import 'package:doan1/BLOC/screen/booking_widget/vehicle_booking_item/vehicle_booking_item_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../BLOC/profile/booker/booker_bloc.dart';
import '../check_user_booking_screen.dart';


class VehicleCheckBookingDetailScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat("#,###");
    var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
    var bookerBloc = context.read<BookerBloc>();
    var vehicleBookingItemBloc = context.read<VehicleBookingItemBloc>();
    return BlocListener<VehicleBookingItemBloc,VehicleBookingItemState>(
      listenWhen: (previous,current) =>
      current is VehicleBookingItemInitial ||
          current is VehicleBookingItemRejectSuccess ||
          current is VehicleBookingItemDeleteSuccess,
      listener: (context,state){
        if(state is VehicleBookingItemDeleteSuccess){
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
      child: BlocBuilder<VehicleBookingItemBloc,VehicleBookingItemState>(
        buildWhen: (previous,current) =>
        current is VehicleBookingItemInitial ||
            current is VehicleBookingItemApproveSuccess ||
            current is VehicleBookingItemRejectSuccess,
        builder:(context,state) => SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: IconButton(
                  onPressed: () {
                    vehicleBookingItemBloc.add(VehicleBookingItemInitialEvent(
                        dateBooking: bookerBloc.listVehicleBookingOrder![vehicleBookingItemBloc.index!],
                        index: vehicleBookingItemBloc.index!));
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                        CheckUserBookingScreen(user: vehicleBookingItemBloc.user,)));
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
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
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
                                      'Pay at place',
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
                            state is VehicleBookingItemInitial ?
                              state.getDataSuccess == true ?
                                vehicleBookingItemBloc.dateBooking!.suspended! == true ?
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
                                                vehicleBookingItemBloc.add(VehicleBookingItemDeleteEvent());
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
                                vehicleBookingItemBloc.dateBooking!.approved! == true ?
                                  Column(
                              children: [
                                Text(
                                  'Your reservation has been approved',
                                  style: GoogleFonts.raleway(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.2,
                                    color: Colors.green,
                                  ),
                                ),
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
                                      side: const BorderSide(
                                        color: Colors.grey,
                                        width: 0.7,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text("Return",
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
                                  Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
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
                                                  vehicleBookingItemBloc.add(VehicleBookingItemRejectEvent());
                                                  bookerBloc.add(GetBookerEvent(ownerId: vehicleBookingItemBloc.user!.id,page: 1));
                                                  vehicleBookingItemBloc.add(VehicleBookingItemRefreshEvent());
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
                                      primary: Colors.grey,
                                      minimumSize: const Size(double.infinity, 50.0),
                                      elevation: 0.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text("Reject",
                                        style: GoogleFonts.raleway(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                        ),),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20,),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: (){
                                      vehicleBookingItemBloc.add(VehicleBookingItemApproveEvent());
                                      bookerBloc.add(GetBookerEvent(ownerId: vehicleBookingItemBloc.user!.id,page: 1));
                                      vehicleBookingItemBloc.add(VehicleBookingItemRefreshEvent());
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
                                      child: Text("Approve",
                                        style: GoogleFonts.raleway(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                        ),),
                                    ),
                                  ),
                                ),
                              ],)
                                :
                              const Center(child: CircularProgressIndicator(),)
                            :
                            state is VehicleBookingItemApproveSuccess ?
                            state.approveSuccess == true ?
                            Column(
                              children: [
                                Text(
                                  'Your reservation has been approved',
                                  style: GoogleFonts.raleway(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.2,
                                    color: Colors.green,
                                  ),
                                ),
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
                                      side: const BorderSide(
                                        color: Colors.grey,
                                        width: 0.7,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text("Return",
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
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
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
                                                  vehicleBookingItemBloc.add(VehicleBookingItemRejectEvent());
                                                  bookerBloc.add(GetBookerEvent(ownerId: vehicleBookingItemBloc.user!.id,page: 1));
                                                  vehicleBookingItemBloc.add(VehicleBookingItemRefreshEvent());
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
                                      primary: Colors.grey,
                                      minimumSize: const Size(double.infinity, 50.0),
                                      elevation: 0.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text("Reject",
                                        style: GoogleFonts.raleway(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                        ),),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20,),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: (){
                                      vehicleBookingItemBloc.add(VehicleBookingItemApproveEvent());
                                      bookerBloc.add(GetBookerEvent(ownerId: vehicleBookingItemBloc.user!.id,page: 1));
                                      vehicleBookingItemBloc.add(VehicleBookingItemRefreshEvent());
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
                                      child: Text("Approve",
                                        style: GoogleFonts.raleway(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                        ),),
                                    ),
                                  ),
                                ),
                              ],)
                                :
                            state is VehicleBookingItemRejectSuccess ?
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
                                                vehicleBookingItemBloc.add(VehicleBookingItemDeleteEvent());
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
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
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
                                                  vehicleBookingItemBloc.add(VehicleBookingItemRejectEvent());
                                                  bookerBloc.add(GetBookerEvent(ownerId: vehicleBookingItemBloc.user!.id,page: 1));
                                                  vehicleBookingItemBloc.add(VehicleBookingItemRefreshEvent());
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
                                      primary: Colors.grey,
                                      minimumSize: const Size(double.infinity, 50.0),
                                      elevation: 0.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text("Reject",
                                        style: GoogleFonts.raleway(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                        ),),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20,),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: (){
                                      vehicleBookingItemBloc.add(VehicleBookingItemApproveEvent());
                                      bookerBloc.add(GetBookerEvent(ownerId: vehicleBookingItemBloc.user!.id,page: 1));
                                      vehicleBookingItemBloc.add(VehicleBookingItemRefreshEvent());
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
                                      child: Text("Approve",
                                        style: GoogleFonts.raleway(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                        ),),
                                    ),
                                  ),
                                ),
                              ],)
                                : const Center(child: CircularProgressIndicator(),),
                            const SizedBox(height: 20,),
                          ]),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}