import 'package:doan1/BLOC/profile/edit_vehicle/edit_vehicle_item_bloc.dart';
import 'package:doan1/BLOC/profile/manage_hotel_car/manage_service_bloc.dart';
import 'package:doan1/screens/profile/floating_button/widget/dialog/vehicle_delete_dialog.dart';
import 'package:doan1/screens/profile/floating_button/widget/vehicle/edit_vehicle_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../BLOC/profile/profile_view/profile_bloc.dart';

class EditVehicleItem extends StatelessWidget{
  final formatCurrency = NumberFormat("#,###");
  @override
  Widget build(BuildContext context) {
    var editVehicleBloc = context.read<EditVehicleItemBloc>();
    var manageServiceBloc = context.read<ManageServiceBloc>();
    var profileBloc = context.read<ProfileBloc>();
    deleteVehicle()=>{
      editVehicleBloc.add(VehicleItemDeleteEvent(editVehicleBloc.vehicle!.id!)),
      manageServiceBloc.add(GetDataByOwner(profileBloc.user!.id,1)),
      Navigator.pop(context)
    };

    return BlocBuilder<EditVehicleItemBloc,EditVehicleItemState>(
      builder: (context,state)=>
      editVehicleBloc.vehicle != null ?
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
                    editVehicleBloc.vehicle!=null ?
                    FadeInImage(
                      width: MediaQuery.of(context).size.width * 0.325,
                      height: MediaQuery.of(context).size.height * 0.15,
                      imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                      image:
                      NetworkImage(editVehicleBloc.vehicle!=null && editVehicleBloc.images!.isNotEmpty ? editVehicleBloc.images![0]: ""),
                      placeholder: const AssetImage('assets/images/loading.gif'),
                      fit: BoxFit.cover,
                    )
                        :
                    const Center(child: CircularProgressIndicator()),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(editVehicleBloc.vehicle!=null? editVehicleBloc.vehicle!.brand as String :"loading...",
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.bold),),
                        const SizedBox(height: 5,),
                        Text(editVehicleBloc.vehicle!=null? '${editVehicleBloc.vehicle!.seats} seats' :"loading...",
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.w400),),
                        Text(editVehicleBloc.vehicle!=null? '${editVehicleBloc.vehicle!.province}, ${editVehicleBloc.vehicle!.city}' :"loading...",
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.w400),),
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
                      editVehicleBloc.vehicle!=null? '${formatCurrency.format(editVehicleBloc.vehicle!.pricePerDay)} VNĐ / day' :"loading...",
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
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) =>
                              BlocProvider.value(
                                value: editVehicleBloc,
                                child: const EditVehicleScreen(),
                          )
                        ));
                      },
                      child:
                      Text(
                        'Detail',
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        ),),
                    ),
                    const SizedBox(width: 10,),
                    ElevatedButton(
                      onPressed: (){
                        showGeneralDialog(context: context,
                            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                              return VehicleDeleteDialog(deleteVehicle: deleteVehicle,);
                            },);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      child:
                      Text(
                        'Delete',
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