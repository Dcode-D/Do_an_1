import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  final Function callbackSetNavbar;

  const BookingScreen({Key? key, required this.callbackSetNavbar})
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
      )
    );
  }
}