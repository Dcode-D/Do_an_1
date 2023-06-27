import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../BLOC/hotel_booking/hotel_booking_bloc.dart';
import '../../../../data/model/hotelroom.dart';
import '../../../BLOC/widget_item/hotel_item/hotel_item_bloc.dart';

class RoomSettingDialog extends StatefulWidget{
  List<HotelRoom> listSelectedHotelRoom = [];

  @override
  _RoomSettingDialogState createState() => _RoomSettingDialogState();
}
class _RoomSettingDialogState extends State<RoomSettingDialog>{
  @override
  Widget build(BuildContext context) {
    var hotelBookingBloc = context.read<HotelBookingBloc>();
    var hotelItemBloc = context.read<HotelItemBloc>();
    final formatCurrency = NumberFormat("#,###");
    return BlocBuilder<HotelItemBloc,HotelItemState>(
      builder:(context,state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed:() => Navigator.pop(context),
                      icon: const Icon(Icons.close)),
                  Text(
                    "Room",
                    style: GoogleFonts.raleway(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                      onPressed:() {
                        hotelBookingBloc.add(SetRoomEvent(hotelRoom: widget.listSelectedHotelRoom));
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.check,color: Colors.green,)),
                ],
              ),
              hotelItemBloc.listHotelRoom == null ? const Center(child: CircularProgressIndicator()) :
              hotelItemBloc.listHotelRoom!.isEmpty ? const Center(child: Text('No room available')) :
              Expanded(
                child: ListView.builder(
                  itemCount: hotelItemBloc.listHotelRoom!.length,
                  itemBuilder: (context,index){
                    return CheckboxListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hotelItemBloc.listHotelRoom![index].number == null ? 'No number' :
                            'Room ${hotelItemBloc.listHotelRoom![index].number!}',
                            style: GoogleFonts.raleway(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            hotelItemBloc.listHotelRoom![index].adultCapacity == null ? 'No adult' :
                            'Adult capacity: ${hotelItemBloc.listHotelRoom![index].adultCapacity!}',
                            style: GoogleFonts.raleway(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            hotelItemBloc.listHotelRoom![index].childrenCapacity == null ? 'No child' :
                            'Child capacity: ${hotelItemBloc.listHotelRoom![index].childrenCapacity!}',
                            style: GoogleFonts.raleway(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            hotelItemBloc.listHotelRoom![index].price == null ? 'No price' :
                            '${formatCurrency.format(hotelItemBloc.listHotelRoom![index].price!)} vnđ / night',
                            style: GoogleFonts.raleway(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                hotelItemBloc.listHotelRoom![index].checkInHour == null ? 'No check in' :
                                'Check in: ${hotelItemBloc.listHotelRoom![index].checkInHour!}:${hotelItemBloc.listHotelRoom![index].checkInMinute!}',
                                style: GoogleFonts.raleway(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                hotelItemBloc.listHotelRoom![index].checkOutHour == null ? 'No check out' :
                                'Check out: ${hotelItemBloc.listHotelRoom![index].checkOutHour!}:${hotelItemBloc.listHotelRoom![index].checkOutMinute!}',
                                style: GoogleFonts.raleway(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ]
                      ),
                        value: widget.listSelectedHotelRoom.contains(hotelItemBloc.listHotelRoom![index]),
                      onChanged: (value){
                        setState(() {
                          if(value!){
                            widget.listSelectedHotelRoom.add(hotelItemBloc.listHotelRoom![index]);
                          }else{
                            widget.listSelectedHotelRoom.remove(hotelItemBloc.listHotelRoom![index]);
                          }
                        });
                      },

                    );
                  },
                ),
              ),
            ],)
        ),
      ),
    );
  }

}