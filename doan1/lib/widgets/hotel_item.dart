import 'dart:ui';

import 'package:doan1/screens/detail_screens/hotel/hotel_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../models/hotel_model.dart';

class HotelItem extends StatelessWidget{
  final Hotel hotel;
  final Image hotelImg;
  final int type;

  HotelItem({
    Key? key,
    required this.hotel,
    required this.hotelImg,
    required this.type
  }) : super(key: key);

  final formatCurrency = NumberFormat("#,###");

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: type == 1 ? 280 : 300,
      child: GestureDetector(
        onTap: () => Navigator.push(context,
          MaterialPageRoute(
            builder: (_) => HotelDetailScreen(
              hotel: hotel,
              hotelImg: hotelImg,
              type: type,
            ),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(10.0),
          width: type == 1 ? 240.0 : 260.0,
          height: type == 1 ? 260.0 : 265.0,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Positioned(
                bottom: 0.0,
                child: Container(
                  height: type == 1 ? 120.0 : 150.0,
                  width: type == 1 ? 240.0 : 320.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          hotel.name,
                          style: TextStyle(
                            fontSize: type == 1 ? 22.0 : 24.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          hotel.address,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          '${formatCurrency.format(int.parse(hotel.price))} / night',
                          style: TextStyle(
                            fontSize: type == 1 ? 18.0 : 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                    height: type == 1 ? 180.0 : 185.0,
                    width: type == 1 ? 220.0 : 260.0,
                    image: AssetImage(hotel.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}