import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../models/hotel_model.dart';

class HotelDetailScreen extends StatefulWidget{
  final Hotel hotel;
  final Image hotelImg;
  final int type;

  const HotelDetailScreen({
    Key? key,
    required this.hotel,
    required this.hotelImg,
    required this.type
  }) : super(key: key);

  @override
  _HotelDetailScreenState createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}