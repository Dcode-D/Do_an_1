import 'package:doan1/BLOC/screen/all_screen/all_vehicle/all_vehicle_bloc.dart';
import 'package:doan1/BLOC/widget_item/car_item/car_item_bloc.dart';
import 'package:doan1/screens/all/all_vehicle_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../BLOC/profile/profile_view/profile_bloc.dart';
import '../../BLOC/screen/book_history/book_history_bloc.dart';
import '../../data/model/vehicle.dart';
import '../../widgets/vehicle_item.dart';

class VehicleRentCarousel extends StatelessWidget {
  final PageController listController = PageController();

  @override
  Widget build(BuildContext context) {
    var allVehicleBloc = context.read<AllVehicleBloc>();
    var profileBloc = context.read<ProfileBloc>();
    var bookHistoryBloc = context.read<BookHistoryBloc>();

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
                      builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider<AllVehicleBloc>(
                              create:(BuildContext context)=> AllVehicleBloc()..add(GetVehicleListEvent())),
                          BlocProvider<ProfileBloc>.value(
                              value: profileBloc),
                          BlocProvider<BookHistoryBloc>.value(
                              value: bookHistoryBloc),
                        ],
                          child: AllVehicleScreen())));
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
        BlocBuilder<AllVehicleBloc, AllVehicleState>(
          builder: (context, state) {
            return SizedBox(
              height: 300.0,
              child:
              state.getListVehicleSuccess == true
                  ?
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: listController,
                scrollDirection: Axis.horizontal,
                itemCount: allVehicleBloc.listVehicle!.length ,
                itemBuilder:(BuildContext context, int index) {
                  if (index < allVehicleBloc.listVehicle!.length) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider<ProfileBloc>.value(
                          value: profileBloc,
                        ),
                        BlocProvider<AllVehicleBloc>.value(
                          value: allVehicleBloc,
                        ),
                        BlocProvider<BookHistoryBloc>.value(
                            value: bookHistoryBloc),
                      ],
                      child: BlocProvider<CarItemBloc>(
                          create: (_) => CarItemBloc()..add(GetCarItemEvent(vehicleId: allVehicleBloc.listVehicle![index].id!)),
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
              : const Center(child: CircularProgressIndicator())
              ,
            );
          },
        ),
        BlocBuilder<AllVehicleBloc, AllVehicleState>(
          builder: (context, state) =>
            state.getListVehicleSuccess == true
                ?
              SmoothPageIndicator(
                controller: listController,
                count: (allVehicleBloc.listVehicle!.length/2).round()+1,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Colors.orange,
                  dotColor: Color(0xFFababab),
                  dotHeight: 4.8,
                  dotWidth: 6,
                  spacing: 4.8,
                ),
              ) :
              const Center(
                child: CircularProgressIndicator(),
              )
        ),
      ],
    );
  }
}