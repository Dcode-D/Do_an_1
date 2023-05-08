import 'package:doan1/screens/profile/bank/add_bank_account.dart';
import 'package:doan1/widgets/salomon_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatelessWidget{
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
      controller: _scrollController,
        headerSliverBuilder: (context,value){
          return [
            SliverAppBar(
              centerTitle: true,
              floating: true,
              pinned: true,
              snap: true,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: true,
              title: const Text(
                'Personal Information',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: IconButton(
                    onPressed: (){
                      SmartDialog.show(builder: (context){
                        return Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width*0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                'Are you sure to save your\ninformation?',
                                textAlign: TextAlign.center,
                                softWrap: true,
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.red,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: TextButton(
                                      onPressed: (){
                                        SmartDialog.dismiss();
                                      },
                                      child: Text(
                                        'No',
                                        style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green,
                                        boxShadow: [
                                      BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: TextButton(
                                      onPressed: (){
                                        SmartDialog.dismiss();
                                      },
                                      child: Text(
                                        'Yes',
                                        style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      });
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            )
          ];
        },
          body: SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
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
                          const Icon(
                            FontAwesomeIcons.user,
                            color: Colors.black,
                            size: 20,
                          ), const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Full Name',
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
                              FontAwesomeIcons.mapMarkerAlt,
                              color: Colors.black,
                              size: 20,
                            ), const SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Address',
                                ),
                                keyboardType: TextInputType.streetAddress,
                                initialValue: 'Thành phố Lâm Đồng',
                              ),
                            ),
                          ]
                      ),
                      Row(
                          children:[
                            Icon(
                              FontAwesomeIcons.addressCard,
                              color: Colors.black,
                              size: 20,
                            ), const SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'ID Card',
                                ),
                                keyboardType: TextInputType.number,
                                initialValue: '079212312312',
                              ),
                            ),
                          ]
                      ),
                      Row(
                          children:[
                            Icon(
                              FontAwesomeIcons.birthdayCake,
                              color: Colors.black,
                              size: 20,
                            ), const SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Date of birth',
                                ),
                                keyboardType: TextInputType.datetime,
                                initialValue: '15/10/2002',
                              ),
                            ),
                          ]
                      )
                    ]
                  ),
      ),
              ),
              SizedBox(height: 10),
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
                    children: [
                      Row(
                          children:[
                            const Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                              size: 20,
                            ), const SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Email',
                                ),
                                keyboardType: TextInputType.emailAddress,
                                initialValue: 'EngDungMup123@gmail.com',
                              ),
                            ),
                          ]
                      ),
                      Row(
                          children:[
                            const Icon(
                              FontAwesomeIcons.phone,
                              color: Colors.black,
                              size: 20,
                            ), const SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Phone Number',
                                ),
                                keyboardType: TextInputType.emailAddress,
                                initialValue: '091231845121',
                              ),
                            ),
                          ]
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.bank,
                            color: Colors.black,
                            size: 20,
                          ), const SizedBox(width: 20),
                          Text(
                            "Not Linked",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Raleway',
                              color: Colors.black,),
                          ),
                          const Spacer(),
                          ElevatedButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddBankScreen()));
                              },
                              child: const Text(
                                  "Add Bank",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Raleway',
                                  color: Colors.black,),
                              )
                          ),
                        ],
                      )
                    ]
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
                    children: [
                      Row(
                          children:[
                            const Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                              size: 20,
                            ), const SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Username',
                                ),
                                keyboardType: TextInputType.number,
                                initialValue: 'dungbeo1510',
                              ),
                            ),
                          ]
                      ),
                      Row(
                          children:[
                            const Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                              size: 20,
                            ), const SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Password',
                                  //TODO: Create state to show password
                                  // suffixIcon: IconButton(
                                  //     onPressed: (){},
                                  //     icon: icon)
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                initialValue: 'dungbeo1510',
                              ),
                            ),
                          ]
                      ),
                    ],
                  ),
                ),
              ),
            ],
        ),
          )
      ),
    );
  }
  
}