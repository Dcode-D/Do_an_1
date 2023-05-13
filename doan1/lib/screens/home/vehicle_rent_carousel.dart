import 'package:doan1/screens/all/all_vehicle_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/vehicle_model.dart';
import '../../widgets/vehicle_item.dart';

class VehicleRentCarousel extends StatelessWidget{
  VehicleRentCarousel({Key? key}) : super(key: key);
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
                'Vehicle rent',
                style: GoogleFonts.raleway(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AllVehicleScreen()));
                },
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
          height: 300.0,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: listController,
            scrollDirection: Axis.horizontal,
            itemCount: vehicles.length,
            itemBuilder: (BuildContext context, int index) {
              Vehicle vehicle = vehicles[index];
              Image vehicleImg = Image.asset(vehicle.imageUrl);
              return VehicleItem(vehicle: vehicle, vehicleImg: vehicleImg, type: 1);
            },
          ),
        ),
        SmoothPageIndicator(
          controller: listController,
          count: (vehicles.length/2).round(),
          effect: const ExpandingDotsEffect(
            activeDotColor: Color(0xFF8a8a8a),
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