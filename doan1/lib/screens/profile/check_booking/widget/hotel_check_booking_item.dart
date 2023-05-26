import 'package:doan1/screens/profile/check_booking/detail_booking/hotel_check_booking_detail_screen.dart';
import 'package:flutter/material.dart';

class HotelCheckBookingItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  Icon(
                    Icons.hotel, size: 25,
                  ),
                  const SizedBox(width: 10,),
                  Text('Hotel',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold),),
                  Spacer(),
                  Text('12/12/2021',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold),),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage('assets/images/hotel0.jpg'),
                    width: MediaQuery.of(context).size.width * 0.325,
                    height: MediaQuery.of(context).size.height * 0.15,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hotel name'
                        ,style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold),),
                      const SizedBox(height: 5,),
                      Text('Type of room booking'
                        ,style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Roboto',
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
                  children:[
                    Text(
                      'Status: Pending',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Total: 1000\$',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ]
              ),
              Row(
                children: [
                  Text(
                    'Name of user who booked this hotel',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HotelCheckBookingDetailScreen()));
                    },
                    child:
                    Text(
                      'Detail',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Roboto',
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
    );
  }

}