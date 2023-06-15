import 'package:dio/dio.dart';
import 'package:doan1/screens/booking/detail_booking/rent_vehicle_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../BLOC/screen/widget/vehicle_booking_item/vehicle_booking_item_bloc.dart';

class VehicleBookingItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat("#,###");
    var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
    var vehicleBookingItemBloc = context.read<VehicleBookingItemBloc>();
    return BlocBuilder<VehicleBookingItemBloc,VehicleBookingItemState>(
      buildWhen: (previous,current) => current is VehicleBookingItemInitial,
      builder:(context,state) =>
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
                    const Icon(
                      FontAwesomeIcons.car, size: 25,
                    ),
                    const SizedBox(width: 10,),
                    Text('Vehicle',
                      style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54
                      ),),
                    const Spacer(),
                    vehicleBookingItemBloc.dateBooking == null ? const Text('Loading...') :
                    Text(
                      '${vehicleBookingItemBloc.dateBooking!.startDate!.day}/${vehicleBookingItemBloc.dateBooking!.startDate!.month}/${vehicleBookingItemBloc.dateBooking!.startDate!.year}',
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
                    vehicleBookingItemBloc.vehicle != null ?
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
                        NetworkImage(vehicleBookingItemBloc.vehicle!=null && vehicleBookingItemBloc.vehicle!.images!.isNotEmpty ?
                        '$baseUrl/files/${vehicleBookingItemBloc.vehicle!.images![0]}': ""),
                        placeholder: const AssetImage('assets/images/loading.gif'),
                        fit: BoxFit.cover,
                      ),
                    ):
                    const Center(child: CircularProgressIndicator()),
                    const SizedBox(width: 10,),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          vehicleBookingItemBloc.vehicle == null ? const Text('Loading...') :
                          Text(vehicleBookingItemBloc.vehicle!.brand!
                            ,style: GoogleFonts.raleway(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54
                              )),
                          const SizedBox(height: 5,),
                          vehicleBookingItemBloc.vehicle == null ? const Text('Loading...') :
                          Text(vehicleBookingItemBloc.vehicle!.address!
                            ,style: GoogleFonts.raleway(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54
                            ),),
                        ],),
                    )
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
                      vehicleBookingItemBloc.dateBooking == null ? const Text('Loading...') :
                          vehicleBookingItemBloc.dateBooking!.approved == false ?
                        Text(
                          'Status: Pending',
                          style: GoogleFonts.raleway(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54
                          ),
                        ) :
                        Text(
                          'Status: Approved',
                          style: GoogleFonts.raleway(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54
                          ),
                        ),
                      const Spacer(),
                      vehicleBookingItemBloc.vehicle == null ? const Text('Loading...') :
                      Text(
                        'Total: ${formatCurrency.format(vehicleBookingItemBloc.vehicle!.pricePerDay)} VNĐ',
                        style: GoogleFonts.raleway(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54
                        ),
                      ),
                    ]
                ),
                Row(
                  children: [
                    const Text(
                      'Optional Information',
                      style: TextStyle(
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
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => RentVehicleHistoryScreen()));
                      },
                      child:
                      Text(
                        'Detail',
                        style: GoogleFonts.raleway(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
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