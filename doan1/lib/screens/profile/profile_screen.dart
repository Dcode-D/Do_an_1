import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final Function callbackSetNavbar;

  const ProfileScreen({Key? key, required this.callbackSetNavbar}) : super(key: key);

  @override
  createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Text('Profile Screen')),
      ),
    );
  }
}