import 'package:doan1/screens/home/hotel_carousel.dart';
import 'package:doan1/widgets/salomon_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/destination_model.dart';
import '../../models/tour_model.dart';
import 'destination_carousel.dart';
import 'tour_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
    createState() => _HomeScreenState();
}

class  _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.5,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 7), // changes position of shadow
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage("assets/images/home_background.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                  child: Column(
                    children: [
                      Row(
                          children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage("assets/images/avatar-wallpaper.jpg"),
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: IconButton(onPressed: (){},
                                    icon: Icon(FontAwesomeIcons.solidBell, color: Colors.white, size: 25,)),
                              ),
                          ],
                        ),
                      Spacer(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Where's your\nnext destination?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Column(
                            children:[
                            Container(
                              height: 64, width: 64,
                              decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                        ),
                              child: IconButton(onPressed: (){},
                          icon: Icon(FontAwesomeIcons.flag, color: Colors.white, size: 25,),),
                      ),
                            SizedBox(height: 10,),
                              Text(
                              "Tours",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            ],),
                          Spacer(),
                          Column(
                            children:[
                              Container(
                                height: 64,
                                width: 64,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(onPressed: (){},
                                  icon: Icon(FontAwesomeIcons.building, color: Colors.white, size: 25,),),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "Hotel",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],),
                          Spacer(),
                          Column(
                            children:[
                              Container(
                                height: 64,
                                width: 64,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(onPressed: (){},
                                  icon: Icon(FontAwesomeIcons.car, color: Colors.white, size: 25,),),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "Car",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],),
                          Spacer(),
                          Column(
                            children:[
                              Container(
                                height: 64,
                                width: 64,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(onPressed: (){},
                                  icon: Icon(FontAwesomeIcons.taxi, color: Colors.white, size: 25,),),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "Taxi",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],),
                        ],),
                      SizedBox(height: 10,),
                    ],
                  ),
                )
                ),
              SizedBox(height: 15,),
              DestinationCarousel(destinationList: destinationList),
              SizedBox(height: 10,),
              TourCarousel(tourList: tours),
              SizedBox(height: 10,),
              HotelCarousel(),
              SizedBox(height: 80),

            ],
          )
        ),
      )
    );
  }
}