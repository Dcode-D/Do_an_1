import 'package:doan1/BLOC/profile/profile_view/profile_bloc.dart';
import 'package:doan1/BLOC/widget_item/hotel_item/hotel_item_bloc.dart';
import 'package:doan1/data/model/hotel.dart';
import 'package:doan1/screens/all/all_hotel_screen.dart';
import 'package:doan1/widgets/hotel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../BLOC/screen/home/home_bloc.dart';


class HotelCarousel extends StatelessWidget {

  final PageController listController = PageController();

  @override
  Widget build(BuildContext context) {
    var homeBloc = context.read<HomeBloc>();
    var profileBloc = context.read<ProfileBloc>();
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  MultiBlocProvider(
                      providers: [
                        BlocProvider<HomeBloc>.value(value: homeBloc),
                        BlocProvider<ProfileBloc>.value(value: profileBloc),
                      ],
                      child: AllHotelScreen())));
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
          builder:(context,state)=>
              SizedBox(
                height: 310.0,
                child:
                state.getDataSuccess == true?
                ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: listController,
                scrollDirection: Axis.horizontal,
                itemCount: homeBloc.listHotel!.length,
                itemBuilder: (BuildContext context, int index) {
                  Hotel hotel = homeBloc.listHotel![index];
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<HomeBloc>.value(value: homeBloc),
                      BlocProvider<ProfileBloc>.value(value: profileBloc),
                    ],
                    child: BlocProvider<HotelItemBloc>(
                      create: (context)=>HotelItemBloc()..add(GetHotelItemEvent(hotel: hotel)),
                        child: HotelItem( type: 1)),
                  );
                }
                ):const Center(child: CircularProgressIndicator(),
            ),
          ),
        ),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) =>
            state.getDataSuccess == true?
            SmoothPageIndicator(
            controller: listController,
            count: (homeBloc.listHotel!.length/2).round()+1,
            effect: const ExpandingDotsEffect(
              activeDotColor: Colors.orange,
              dotColor: Color(0xFFababab),
              dotHeight: 4.8,
              dotWidth: 6,
              spacing: 4.8,
            ),
          ) :
            const CircularProgressIndicator()
        ),
      ],
    );
  }
}
