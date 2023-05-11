import 'package:flutter/material.dart';
import 'package:doan1/models/notification_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationItem extends StatelessWidget{
  final NotificationInfo notificationinfo;

  NotificationItem({
    Key? key,
    required this.notificationinfo,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(0, 0),
          ),],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Icon(
              notificationinfo.type == 'alert' ?
              FontAwesomeIcons.warning : FontAwesomeIcons.infoCircle
              ,
              color: Colors.orange,
              size: 40,),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notificationinfo.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  notificationinfo.content,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                Text(
                  notificationinfo.time,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}