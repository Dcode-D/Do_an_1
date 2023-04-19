import 'package:doan1/BLOC/authentication/authentication_page.dart';
import 'package:doan1/screens/login/login_screens.dart';
import 'package:doan1/screens/login/signup_screens.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Travel UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeIn,
          child: AuthenticationPage()),
    );
  }
}