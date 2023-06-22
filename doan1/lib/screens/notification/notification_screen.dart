import 'package:doan1/models/notification_model.dart';
import 'package:doan1/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationInfoScreen extends StatelessWidget{
  const NotificationInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Notification',
            style: GoogleFonts.raleway(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600)
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                NotificationInfo info = notifications[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: NotificationItem(notificationinfo: info,),
                );
              },
          ),
        )
      ),
    );
  }

}