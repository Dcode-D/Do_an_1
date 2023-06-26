import 'package:doan1/BLOC/authentication/authentication_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'Notifications/notification_service.dart';
import 'dependency.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocalNotificationService.initialize();
    return MaterialApp(
      title: 'Flutter Travel UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      builder: FlutterSmartDialog.init(),
      home: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeIn,
          child: AuthenticationPage()),
    );
  }
}