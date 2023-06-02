import 'package:doan1/BLOC/widget_item/hotel_item/hotel_item_bloc.dart';
import 'package:doan1/screens/all/all_widget/hotel_item_for_all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BLOC/profile/profile_view/profile_bloc.dart';
import '../../BLOC/screen/home/home_bloc.dart';
import '../../data/model/hotel.dart';

class AllHotelScreen extends StatelessWidget{
  final PageController listController = PageController();
  @override
  Widget build(BuildContext context) {
    var homeBloc = context.read<HomeBloc>();
    var profileBloc = context.read<ProfileBloc>();
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Hotels for you',
            style: GoogleFonts.raleway(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600
            )
          ),
        ),
      body: BlocBuilder<HomeBloc,HomeState>(
        builder:(context,state) =>
        state.getDataSuccess == true ?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: listController,
              itemCount: homeBloc.listHotel!.length,
              itemBuilder: (BuildContext context, int index){
                Hotel hotel = homeBloc.listHotel![index];
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<HomeBloc>.value(value: homeBloc),
                    BlocProvider<ProfileBloc>.value(value: profileBloc),
                  ],
                  child: BlocProvider<HotelItemBloc>(
                    create: (context)=> HotelItemBloc()..add(GetHotelItemEvent(hotel: hotel)),
                      child: HotelItemForAll()),
                );
              }
          ),
        ) :
            Text('Loading data...',
              style: GoogleFonts.raleway(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600
              ),)
      )
    );
  }

}