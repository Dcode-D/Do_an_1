import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BankSelectionScreen extends StatelessWidget {
  const BankSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: const Color(0xffF9F9F9),
          actions: [
            IconButton(
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
              },
              icon: const Icon(
                Icons.check,
                color: Colors.green,
              ),
            ),
          ],
          title: const Text("Bank",
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              )
          ),
        ),
      body: Column(
        )
      );
  }
}