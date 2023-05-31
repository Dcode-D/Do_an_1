import 'package:doan1/BLOC/widget_item/car_item/car_item_bloc.dart';
import 'package:doan1/screens/all/all_vehicle_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../BLOC/screen/home/home_bloc.dart';
import '../../data/model/vehicle.dart';
import '../../widgets/vehicle_item.dart';

class VehicleRentCarousel extends StatelessWidget{
  final PageController listController = PageController();

  @override
  Widget build(BuildContext context) {
    var homeBloc = context.read<HomeBloc>();
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
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AllVehicleScreen()));
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
            itemCount: homeBloc.listVehicle!.length,
            itemBuilder: (BuildContext context, int index) {
              Vehicle vehicle = homeBloc.listVehicle![index];
              var carItemBloc = context.read<CarItemBloc>();
              carItemBloc.add(GetCarItemEvent(vehicle: vehicle));
              return BlocProvider(
                create: (_) => CarItemBloc(),
                  child: VehicleItem(type: 1));
            },
          ),
        ),
        SmoothPageIndicator(
          controller: listController,
          count: (homeBloc.listVehicle!.length/2).round(),
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