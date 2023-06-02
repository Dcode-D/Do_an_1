import 'package:doan1/BLOC/screen/all_screen/all_hotel/all_hotel_bloc.dart';
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
  final ScrollController listController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var allHotelBloc = context.read<AllHotelBloc>();
    var profileBloc = context.read<ProfileBloc>();
    return BlocBuilder<AllHotelBloc,AllHotelState>(
      builder:(context,state) =>
      Scaffold(
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
        body: state.getListHotelSuccess == true ?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: listController,
              itemCount: allHotelBloc.listHotel!.length,
              itemBuilder: (BuildContext context, int index){
                Hotel hotel = allHotelBloc.listHotel![index];
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<AllHotelBloc>.value(value: allHotelBloc),
                    BlocProvider<ProfileBloc>.value(value: profileBloc),
                  ],
                  child: BlocProvider<HotelItemBloc>(
                    create: (context)=> HotelItemBloc()..add(GetHotelItemEvent(hotel: hotel)),
                      child: HotelItemForAll(type: 1,)),
                );
              }
          ),
        ) :
        const Center(child: CircularProgressIndicator(),)
      ),
    );
  }

}