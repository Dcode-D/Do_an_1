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
                  image: const DecorationImage(
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
                                child: const CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage("assets/images/avatar-wallpaper.jpg"),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: IconButton(onPressed: (){},
                                    icon: const Icon(FontAwesomeIcons.solidBell, color: Colors.white, size: 25,)),
                              ),
                          ],
                        ),
                      const Spacer(),
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
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
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
                            icon: const Icon(FontAwesomeIcons.flag, color: Colors.white, size: 25,),),
                        ),
                              const SizedBox(height: 10,),
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
                            const Spacer(),
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
                                    icon: const Icon(FontAwesomeIcons.building, color: Colors.white, size: 25,),),
                                ),
                                const SizedBox(height: 10,),
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
                            const Spacer(),
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
                                    icon: const Icon(FontAwesomeIcons.car, color: Colors.white, size: 25,),),
                                ),
                                const SizedBox(height: 10,),
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
                          ],),
                      ),
                      const SizedBox(height: 10,),
                    ],
                  ),
                )
                ),
              const SizedBox(height: 15,),
              DestinationCarousel(destinationList: destinationList),
              const SizedBox(height: 10,),
              TourCarousel(tourList: tours),
              const SizedBox(height: 10,),
              HotelCarousel(),
              const SizedBox(height: 80),
            ],
          )
        ),
      )
    );
  }
}