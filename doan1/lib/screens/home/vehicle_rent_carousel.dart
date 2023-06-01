import 'package:doan1/BLOC/widget_item/car_item/car_item_bloc.dart';
import 'package:doan1/screens/all/all_vehicle_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../BLOC/screen/home/home_bloc.dart';
import '../../data/model/vehicle.dart';
import '../../widgets/vehicle_item.dart';

class VehicleRentCarousel extends StatelessWidget {
  final PageController listController = PageController();

  @override
  Widget build(BuildContext context) {
    var homeBloc = context.read<HomeBloc>();
    void _ListListener(){
      if(listController.page == homeBloc.listVehicle!.length-1)  {
        //TODO: add more data event
      }
    }
    listController.addListener(_ListListener);
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
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => AllVehicleScreen()));
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
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return SizedBox(
              height: 300.0,
              child:
              state.getDataSuccess == true?
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: listController,
                scrollDirection: Axis.horizontal,
                itemCount: homeBloc.listVehicle!.length ,
                itemBuilder:(BuildContext context, int index) {
                  Vehicle vehicle = homeBloc.listVehicle![index];
                  if (index < homeBloc.listVehicle!.length) {
                    return BlocProvider<HomeBloc>.value(
                      value: homeBloc,
                      child: BlocProvider<CarItemBloc>(
                          create: (_) => CarItemBloc()..add(GetCarItemEvent(vehicle: vehicle)),
                          child: VehicleItem(type: 1)),
                    );
                  }
                  else {
                    return Center(
                      child: Text(
                          'Loading more...',
                          style: GoogleFonts.raleway(
                            fontSize: 20,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                          )),
                    );
                  }
                },
              )
              : const CircularProgressIndicator()
              ,
            );
          },
        ),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if(state.getDataSuccess == false) {
              return const CircularProgressIndicator();
            } else {
              return SmoothPageIndicator(
                controller: listController,
                count: (homeBloc.listVehicle!.length/2).round()+1,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Colors.orange,
                  dotColor: Color(0xFFababab),
                  dotHeight: 4.8,
                  dotWidth: 6,
                  spacing: 4.8,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}