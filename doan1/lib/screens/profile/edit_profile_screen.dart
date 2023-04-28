import 'package:doan1/screens/profile/bank/add_bank_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              title: Text(
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
                      //TODO: Pop dialog to ask are they sure to save information
                    },
                    icon: Icon(
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
                            Icon(
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
                            Icon(
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
                          Icon(
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
                          Spacer(),
                          ElevatedButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddBankScreen()));
                              },
                              child: Text(
                                  "Add Bank",
                                style: const TextStyle(
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
                            Icon(
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
                            Icon(
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