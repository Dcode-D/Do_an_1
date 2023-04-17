import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Function callbackSetNavbar;
  const HomeScreen({Key? key,required this.callbackSetNavbar}) : super(key: key);

  @override
    createState() => _HomeScreenState();
}

class  _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Text('Home Screen')),
      ),);
  }
}