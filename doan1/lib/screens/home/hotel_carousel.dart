import 'package:doan1/BLOC/profile/profile_view/profile_bloc.dart';
import 'package:doan1/BLOC/widget_item/hotel_item/hotel_item_bloc.dart';
import 'package:doan1/data/model/hotel.dart';
import 'package:doan1/screens/all/all_hotel_screen.dart';
import 'package:doan1/widgets/hotel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../BLOC/screen/all_screen/all_hotel/all_hotel_bloc.dart';
import '../../BLOC/screen/home/home_bloc.dart';


class HotelCarousel extends StatelessWidget {

  final PageController listController = PageController();

  @override
  Widget build(BuildContext context) {
    var allHotelBloc = context.read<AllHotelBloc>();
    var profileBloc = context.read<ProfileBloc>();


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
                        BlocProvider<AllHotelBloc>.value(value: allHotelBloc),
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
        BlocBuilder<AllHotelBloc, AllHotelState>(
          builder:(context,state)=>
              SizedBox(
                height: 310.0,
                child:
                state.getListHotelSuccess == true?
                ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: listController,
                scrollDirection: Axis.horizontal,
                itemCount: allHotelBloc.listHotel!.length,
                itemBuilder: (BuildContext context, int index) {
                  Hotel hotel = allHotelBloc.listHotel![index];
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<AllHotelBloc>.value(value: allHotelBloc),
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
        BlocBuilder<AllHotelBloc, AllHotelState>(
          builder: (context, state) =>
          state.getListHotelSuccess == true?
            SmoothPageIndicator(
            controller: listController,
            count: (allHotelBloc.listHotel!.length/2).round()+1,
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
