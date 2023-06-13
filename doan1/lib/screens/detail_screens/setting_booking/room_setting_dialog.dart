import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../BLOC/hotel_booking/hotel_booking_bloc.dart';
import '../../../../data/model/hotelroom.dart';

class RoomSettingDialog extends StatefulWidget{
  List<HotelRoom>? hotelRoom;
  List<HotelRoom> listSelectedHotelRoom = [];

  RoomSettingDialog({required this.hotelRoom});

  @override
  _RoomSettingDialogState createState() => _RoomSettingDialogState();
}
class _RoomSettingDialogState extends State<RoomSettingDialog>{
  @override
  Widget build(BuildContext context) {
    var hotelBookingBloc = context.read<HotelBookingBloc>();
    return Padding(
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
            Expanded(
              child: ListView.builder(
                itemCount: widget.hotelRoom!.length,
                itemBuilder: (context,index){
                  return CheckboxListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.hotelRoom![index].number == null ? 'No number' :
                          'Room ${widget.hotelRoom![index].number!}',
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.hotelRoom![index].adultCapacity == null ? 'No adult' :
                          'Adult capacity: ${widget.hotelRoom![index].adultCapacity!}',
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.hotelRoom![index].childrenCapacity == null ? 'No child' :
                          'Child capacity: ${widget.hotelRoom![index].childrenCapacity!}',
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.hotelRoom![index].price == null ? 'No price' :
                          '${widget.hotelRoom![index].price!}\$ / night',
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.hotelRoom![index].checkInHour == null ? 'No check in' :
                              'Check in: ${widget.hotelRoom![index].checkInHour!}:${widget.hotelRoom![index].checkInMinute!}',
                              style: GoogleFonts.raleway(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              widget.hotelRoom![index].checkOutHour == null ? 'No check out' :
                              'Check out: ${widget.hotelRoom![index].checkOutHour!}:${widget.hotelRoom![index].checkOutMinute!}',
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
                      value: widget.listSelectedHotelRoom.contains(widget.hotelRoom![index]),
                    onChanged: (value){
                      setState(() {
                        if(value!){
                          widget.listSelectedHotelRoom.add(widget.hotelRoom![index]);
                        }else{
                          widget.listSelectedHotelRoom.remove(widget.hotelRoom![index]);
                        }
                      });
                    },

                  );
                },
              ),
            ),
          ],)
      ),
    );
  }

}