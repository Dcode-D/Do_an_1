import 'package:doan1/widgets/salomon_bottom_bar.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {

  const BookingScreen({Key? key})
      : super(key: key);

  @override
  createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Text('Booking Screen')),
      ),
    );
  }
}