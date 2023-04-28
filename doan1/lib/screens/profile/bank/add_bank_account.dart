import 'package:doan1/screens/profile/bank/confirm_bank_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddBankScreen extends StatelessWidget{
  final ScrollController _scrollController = ScrollController();
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return[
              SliverAppBar(
                centerTitle: true,
                floating: true,
                pinned: true,
                snap: true,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: true,
                title: Text(
                  'Add bank account',
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
          body: Column(
            children: [
              const SizedBox(height: 30),
              Text(
                'Fill all the data correctly.',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
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
                    children:[
                      Row(
                          children:[
                            Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                              size: 20,
                            ), const SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Card holder name',
                                ),
                                keyboardType: TextInputType.name,
                                initialValue: 'Nguyễn Huy Trí Dũng',
                              ),
                            ),
                          ]
                      ),
                      Row(
                          children:[
                            Icon(
                              FontAwesomeIcons.bank,
                              color: Colors.black,
                              size: 20,
                            ), const SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Bank name',
                                ),
                                keyboardType: TextInputType.name,
                                initialValue: 'Vietcombank',
                              ),
                            ),
                          ]
                      ),
                      Row(
                          children:[
                            Icon(
                              FontAwesomeIcons.creditCard,
                              color: Colors.black,
                              size: 20,
                            ), const SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Your card number',
                                ),
                                keyboardType: TextInputType.number,
                                initialValue: '123123123123',
                              ),
                            ),
                          ]
                      ),
                      Row(
                          children:[
                            Icon(
                              FontAwesomeIcons.creditCard,
                              color: Colors.black,
                              size: 20,
                            ), const SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Account number',
                                ),
                                keyboardType: TextInputType.name,
                                initialValue: '1231233213',
                              ),
                            ),
                          ]
                      ),
                      Row(
                          children:[
                            Icon(
                              FontAwesomeIcons.calendarAlt,
                              color: Colors.black,
                              size: 20,
                            ), const SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Expired date',
                                ),
                                keyboardType: TextInputType.datetime,
                                initialValue: '12/12/2030',
                              ),
                            ),
                          ]
                      ),
                      SizedBox(height: 20),
                    ]
                  )
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.orange,
                  ),
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmBankScreen()));
                      },
                      child: const Center(
                        child: Text(
                          'Next',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ),
              )
            ],
          ),
        )
      );
  }

}