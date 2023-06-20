import 'package:doan1/BLOC/profile/edit_hotel/edit_hotel_item_bloc.dart';
import 'package:doan1/screens/profile/floating_button/widget/dialog/hotel_delete_dialog.dart';
import 'package:doan1/screens/profile/floating_button/widget/hotel/edit_hotel_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../BLOC/profile/manage_hotel_car/manage_service_bloc.dart';

class EditHotelItem extends StatelessWidget{
  final formatCurrency = NumberFormat("#,###");
  @override
  Widget build(BuildContext context) {
    var editHotelBloc = context.read<EditHotelItemBloc>();
    var manageServiceBloc = context.read<ManageServiceBloc>();
    deleteHotel()=>{
      editHotelBloc.add(DeleteHotelItemEvent(editHotelBloc.hotel!.id!)),
      manageServiceBloc.add(DeleteHotelItem(editHotelBloc.index!)),
      Navigator.pop(context)
    };
    return BlocBuilder<EditHotelItemBloc,EditHotelItemState>(
      builder: (context,state)=>
      editHotelBloc.hotel != null ?
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
                      FontAwesomeIcons.hotel, size: 25,
                    ),
                    const SizedBox(width: 10,),
                    Text('Hotel',
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
                    editHotelBloc.hotel!=null ?
                    FadeInImage(
                      width: MediaQuery.of(context).size.width * 0.325,
                      height: MediaQuery.of(context).size.height * 0.15,
                      imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                      image:
                      NetworkImage(editHotelBloc.hotel!=null && editHotelBloc.images!.isNotEmpty ? editHotelBloc.images![0]: ""),
                      placeholder: const AssetImage('assets/images/loading.gif'),
                      fit: BoxFit.cover,
                    )
                        :
                    const Center(child: CircularProgressIndicator()),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(editHotelBloc.hotel!=null? editHotelBloc.hotel!.name as String :"loading..."
                          ,style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.bold),),
                        const SizedBox(height: 5,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.52,
                          child: Text(editHotelBloc.hotel!=null? '${editHotelBloc.hotel!.province!}, ${editHotelBloc.hotel!.city}' :"loading..."
                            ,style: GoogleFonts.roboto(
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
                      editHotelBloc.hotel?.maxPrice !=null && editHotelBloc.hotel?.minPrice !=null?
                      '${formatCurrency.format(((editHotelBloc.hotel!.maxPrice as double) + (editHotelBloc.hotel!.minPrice as double))/2)} VNĐ / night':'?',
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
                          MaterialPageRoute(builder: (context) =>
                              BlocProvider.value(
                              value: editHotelBloc..add(RefreshHotelItemEvent()),
                              child: EditHotelScreen(),
                            ))
                        );
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
                            pageBuilder:
                            (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                              return HotelDeleteDialog(deleteHotel: deleteHotel,);
                            },
                        );
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
      Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

}