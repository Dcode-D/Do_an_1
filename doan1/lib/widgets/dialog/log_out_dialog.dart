import 'package:doan1/BLOC/authentication/authentication_page.dart';
import 'package:flutter/material.dart';


class LogOutDialog extends Dialog{
  Function logout;

  LogOutDialog({required this.logout});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        height:260,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [
            Image.asset("assets/icons/icon-sadness.png", width: 100, height: 100),
            const SizedBox(height: 20),
            const Text("Are you sure you want to log out?",
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black.withOpacity(0.3),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Cancel",
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      )
                  ),
                ),
                ElevatedButton(
                  onPressed:(){
                    logout();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthenticationPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Log Out",
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      )
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}