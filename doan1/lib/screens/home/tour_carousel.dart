
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:doan1/widgets/tour_item.dart';

import '../../models/tour_model.dart';

class TourCarousel extends StatelessWidget {
  final List<Tour> tourList;
  TourCarousel({Key? key, required this.tourList}) : super(key: key);

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
              const Text(
                'Top Tours',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () => print('See All'),
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
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
              Tour tour = tourList[index];
              Image tourImg = Image.asset(tour.img);
              return TourItem(tour: tour, tourImg: tourImg, type: 1);
            },
          ),
        ),
        SmoothPageIndicator(
            controller: listController,
            count: (tours.length/2).round(),
            effect: const ExpandingDotsEffect(
              activeDotColor: Color(0xFF8a8a8a),
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
