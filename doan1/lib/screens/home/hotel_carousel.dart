import 'package:doan1/screens/all/all_hotel_screen.dart';
import 'package:doan1/widgets/hotel_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/hotel_model.dart';


class HotelCarousel extends StatelessWidget {

  final PageController listController = PageController();

  @override
  Widget build(BuildContext context) {
    // void _ListListener(){
    //   if(listController.page == homeBloc.listVehicle!.length-1)  {
    //     //TODO: add more data event
    //   }
    // }
    // listController.addListener(_ListListener);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Exclusive Hotels',
                style: GoogleFonts.raleway(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                )
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AllHotelScreen()));
                },
                child: Text(
                  'See All',
                  style: GoogleFonts.raleway(
                      fontSize: 20,
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                  )
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300.0,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: listController,
            scrollDirection: Axis.horizontal,
            itemCount: hotels.length,
            itemBuilder: (BuildContext context, int index) {
              Hotel hotel = hotels[index];
              Image hotelImg = Image.asset(hotel.imageUrl);
              return HotelItem(hotel: hotel, hotelImg: hotelImg, type: 1);
            },
          ),
        ),
        SmoothPageIndicator(
          controller: listController,
          count: (hotels.length/2).round(),
          effect: const ExpandingDotsEffect(
            activeDotColor: Colors.orange,
            dotColor: Color(0xFFababab),
            dotHeight: 4.8,
            dotWidth: 6,
            spacing: 4.8,
          ),
        ),
      ],
    );
  }
}
