import 'package:doan1/BLOC/profile/edit_vehicle/edit_vehicle_item_bloc.dart';
import 'package:doan1/BLOC/profile/manage_hotel_car/manage_service_bloc.dart';
import 'package:doan1/screens/profile/floating_button/widget/dialog/vehicle_delete_dialog.dart';
import 'package:doan1/screens/profile/floating_button/widget/vehicle/edit_vehicle_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../BLOC/profile/booker/booker_bloc.dart';
import '../check_booking_screen.dart';


class BookingVehicleItem extends StatelessWidget{
  final formatCurrency = NumberFormat("#,###");
  @override
  Widget build(BuildContext context) {
    var editVehicleItemBloc = context.read<EditVehicleItemBloc>();
    var manageServiceBloc = context.read<ManageServiceBloc>();

    return BlocBuilder<EditVehicleItemBloc,EditVehicleItemState>(
      builder: (context,state)=>
      editVehicleItemBloc.vehicle != null ?
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
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.bold),),
                    const Spacer(),
                    Text('12/12/2021',
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.bold),),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    editVehicleItemBloc.vehicle!=null ?
                    FadeInImage(
                      width: MediaQuery.of(context).size.width * 0.325,
                      height: MediaQuery.of(context).size.height * 0.15,
                      imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                      image:
                      NetworkImage(editVehicleItemBloc.vehicle!=null && editVehicleItemBloc.images!.isNotEmpty ? editVehicleItemBloc.images![0]: ""),
                      placeholder: const AssetImage('assets/images/loading.gif'),
                      fit: BoxFit.cover,
                    )
                        :
                    const Center(child: CircularProgressIndicator()),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(editVehicleItemBloc.vehicle!=null? editVehicleItemBloc.vehicle!.brand as String :"loading...",
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.bold),),
                        const SizedBox(height: 5,),
                        Text(editVehicleItemBloc.vehicle!=null? '${editVehicleItemBloc.vehicle!.seats} seats' :"loading...",
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.w400),),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.52,
                          child: Text(editVehicleItemBloc.vehicle!=null? '${editVehicleItemBloc.vehicle!.province}, ${editVehicleItemBloc.vehicle!.city}' :"loading...",
                            softWrap: true,
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.w400),),
                        ),
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
                  children: [
                    Text(
                      editVehicleItemBloc.vehicle!=null? '${formatCurrency.format(editVehicleItemBloc.vehicle!.pricePerDay)} VNĐ / day' :"loading...",
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider<BookerBloc>(
                                  create: (context) => BookerBloc("car", editVehicleItemBloc.vehicle!.id!)..add(GetBookerEvent()),
                                  child: Builder(
                                      builder: (context) {
                                        return CheckBookingScreen();
                                      }
                                  ),
                                )));
                      },
                      child:
                      Text(
                        'Bookings',
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        ),),
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
      )
          :
      const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

}