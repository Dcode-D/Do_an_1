import 'package:doan1/BLOC/profile/edit_profile/edit_profile_bloc.dart';
import 'package:doan1/BLOC/profile/profile_view/profile_bloc.dart';
import 'package:doan1/BLOC/screen/all_screen/all_vehicle/all_vehicle_bloc.dart';
import 'package:doan1/BLOC/screen/home/home_bloc.dart';
import 'package:doan1/screens/all/all_hotel_screen.dart';
import 'package:doan1/screens/all/all_tour_screen.dart';
import 'package:doan1/screens/all/all_vehicle_screen.dart';
import 'package:doan1/screens/home/vehicle_rent_carousel.dart';
import 'package:doan1/screens/home/hotel_carousel.dart';
import 'package:doan1/screens/notification/notification_screen.dart';
import 'package:doan1/screens/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BLOC/screen/all_screen/all_article/article_bloc.dart';
import '../../BLOC/screen/all_screen/all_hotel/all_hotel_bloc.dart';
import '../../models/notification_model.dart';
import 'destination_carousel.dart';
import 'tour_carousel.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var scrollController = ScrollController();
    ProfileBloc profileBloc = context.read<ProfileBloc>();
    AllHotelBloc allHotelBloc = context.read<AllHotelBloc>();
    AllVehicleBloc allVehicleBloc = context.read<AllVehicleBloc>();
    ArticleBloc articleBloc = context.read<ArticleBloc>();
    return
      BlocBuilder<ProfileBloc,ProfileState>(builder: (context, state)=>
          BlocBuilder<HomeBloc,HomeState>(
          builder: (context,state) =>
          Scaffold(
            body: SingleChildScrollView(
              controller: scrollController,
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
                        ),],
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
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                      BlocProvider<ProfileBloc>.value(
                                        value: profileBloc,
                                        child:
                                          BlocProvider(
                                            create: (_) => EditProfileBloc(context),
                                            child: EditProfileScreen(),
                                          )
                                      ))
                                      );
                                    },
                                    child: Container(
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
                                      child:
                                      profileBloc.image != null ?
                                        CircleAvatar(
                                        radius: 40,
                                        backgroundImage:
                                        NetworkImage(context.read<ProfileBloc>().image!))
                                          :
                                          const CircleAvatar(
                                          radius: 40,
                                          backgroundImage:
                                            AssetImage("assets/images/undefine-wallpaper.jpg")
                                          ),
                                      ),
                                    ),
                                  const Spacer(),
                                  Stack(
                                    children: [
                                      Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: IconButton(onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationInfoScreen()));
                                      },
                                          icon: const Icon(
                                            FontAwesomeIcons.solidBell,
                                            color: Colors.white,
                                            size: 25,
                                          )
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                          child:
                                            Container(
                                              height: 18,
                                              width: 18,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(50),
                                              ),
                                              child: Center(
                                                child: Text(
                                                    notifications.length.toString(),
                                                    style: GoogleFonts.raleway(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w700,
                                                    )
                                                ),
                                              ),
                                            ),
                                        ),
                                    ]
                                  ),
                              ],
                            ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Where's your\nnext destination?",
                              style: GoogleFonts.raleway(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600
                              )
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
                                    child: IconButton(
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => AllTourScreen()));
                                      },
                                    icon: const Icon(
                                      FontAwesomeIcons.flag,
                                      color: Colors.white,
                                      size: 25,),
                                      ),
                                    ),
                                  const SizedBox(height: 10,),
                                    Text(
                                    "Tours",
                                    style: GoogleFonts.raleway(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600
                                    )
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
                                      child: IconButton(
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                              MultiBlocProvider(
                                                providers: [
                                                  BlocProvider<ProfileBloc>.value(
                                                    value: profileBloc,
                                                  ),
                                                  BlocProvider<AllHotelBloc>.value(
                                                    value: allHotelBloc,
                                                  ),
                                                ],
                                                  child: AllHotelScreen())));
                                      },
                                        icon: const Icon(
                                          FontAwesomeIcons.building,
                                          color: Colors.white,
                                          size: 25,),
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    Text(
                                      "Hotels",
                                      style: GoogleFonts.raleway(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600
                                      )
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
                                      child: IconButton(
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                              MultiBlocProvider(
                                                providers: [
                                                  BlocProvider<AllVehicleBloc>.value(
                                                    value: allVehicleBloc,),
                                                  BlocProvider<ProfileBloc>.value(
                                                    value: profileBloc,
                                                  ),
                                                ],
                                                  child: AllVehicleScreen())));
                                        },
                                        icon: const Icon(
                                          FontAwesomeIcons.car,
                                          color: Colors.white,
                                          size: 25,),),
                                    ),
                                    const SizedBox(height: 10,),
                                    Text(
                                      "Vehicles",
                                      style: GoogleFonts.raleway(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600
                                      )
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
                  BlocProvider<ArticleBloc>.value(
                    value: articleBloc,
                      child: DestinationCarousel()),
                  const SizedBox(height: 10,),
                  TourCarousel(),
                  const SizedBox(height: 10,),
                  MultiBlocProvider(
                    providers: [
                      BlocProvider<AllHotelBloc>.value(
                        value: allHotelBloc,
                      ),
                      BlocProvider<ProfileBloc>.value(
                        value: profileBloc,
                      ),
                    ],
                      child: HotelCarousel()),
                  const SizedBox(height: 10,),
                  MultiBlocProvider(
                    providers: [
                      BlocProvider<AllVehicleBloc>.value(
                        value: allVehicleBloc,),
                      BlocProvider<ProfileBloc>.value(
                        value: profileBloc,
                      ),
                    ],
                      child: VehicleRentCarousel()),
                  const SizedBox(height: 80),
                ],
              ),
            )
          )
        )
      );
  }

}