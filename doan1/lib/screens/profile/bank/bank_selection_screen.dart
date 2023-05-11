import 'package:doan1/widgets/bank_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/bank_account_model.dart';
import 'add_bank_account.dart';

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
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddBankScreen()));
              },
              icon: const Icon(
                FontAwesomeIcons.add,
                color: Colors.black,
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        child: ListView.builder(
          itemCount: BankAccounts.length,
          itemBuilder: (context, index){
            BankAccount bank = BankAccounts[index];
          return BankItem(bank: bank,);
        },
        ),
      )
    );
  }
}