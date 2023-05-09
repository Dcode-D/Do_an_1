
import 'package:doan1/screens/profile/bank/success_bank_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConfirmBankScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    GlobalKey currentKey = GlobalKey();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return[
            const SliverAppBar(
              centerTitle: true,
              floating: true,
              pinned: true,
              snap: true,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: true,
              title: Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                'Make sure all the data below is correct according to\n'
                    '                    your original bank account data.',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 50),
              Text(
                "Your bank account",
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.3),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                        children:[
                          const Icon(
                            FontAwesomeIcons.user,
                            color: Colors.black,
                            size: 20,
                          ), const SizedBox(width: 20),
                          Text(
                            "Nguyễn Huy Trí Dũng",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Raleway',
                              color: Colors.black,),
                          ),
                        ]),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    const SizedBox(height: 10),
                    Row(
                        children:[
                          const Icon(
                            FontAwesomeIcons.bank,
                            color: Colors.black,
                            size: 20,
                          ), const SizedBox(width: 20),
                          Text(
                            "Vietcombank",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Raleway',
                              color: Colors.black,),
                          ),
                        ]),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    const SizedBox(height: 10),
                    Row(
                        children:[
                          const Icon(
                            FontAwesomeIcons.creditCard,
                            color: Colors.black,
                            size: 20,
                          ), const SizedBox(width: 20),
                          Text(
                            "123123123123",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Raleway',
                              color: Colors.black,),
                          ),
                        ]),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    const SizedBox(height: 10),
                    Row(
                        children:[
                          const Icon(
                            FontAwesomeIcons.creditCard,
                            color: Colors.black,
                            size: 20,
                          ), const SizedBox(width: 20),
                          Text(
                            "1231233213",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Raleway',
                              color: Colors.black,),
                          ),
                        ]),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    const SizedBox(height: 10),
                    Row(
                        children:[
                          const Icon(
                            FontAwesomeIcons.calendarAlt,
                            color: Colors.black,
                            size: 20,
                          ), const SizedBox(width: 20),
                          Text(
                            "12/12/2030",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Raleway',
                              color: Colors.black,),
                          ),
                        ]),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Colors.black.withOpacity(0.3),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange,
                ),
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessBankScreen()));
                    },
                    child: const Center(
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    )),
              )
            ],
          ),
        )
      ),
    );
  }

}