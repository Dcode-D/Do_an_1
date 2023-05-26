
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:doan1/widgets/tour_item.dart';

import '../../models/tour_model.dart';
import '../all/all_tour_screen.dart';

class TourCarousel extends StatelessWidget {

  final PageController listController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Top Tours',
                style: GoogleFonts.raleway(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AllTourScreen()));
                },
                child: Text(
                  'See All',
                  style: GoogleFonts.raleway(
                      fontSize: 20,
                      color: Colors.orange,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w600
                  )
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 320.0,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: listController,
            scrollDirection: Axis.horizontal,
            itemCount: tours.length,
            itemBuilder: (BuildContext context, int index) {
              Tour tour = tours[index];
              Image tourImg = Image.asset(tour.img);
              return TourItem(tour: tour, tourImg: tourImg, type: 1);
            },
          ),
        ),
        SmoothPageIndicator(
            controller: listController,
            count: (tours.length/2).round(),
            effect: const ExpandingDotsEffect(
              activeDotColor: Colors.orange,
              dotColor: Color(0xFFababab),
              dotHeight: 4.8,
              dotWidth: 6,
              spacing: 4.8,
            )
        )
      ],
    );
  }
}
