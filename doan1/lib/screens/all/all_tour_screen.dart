import 'package:doan1/screens/all/all_widget/tour_item_for_all.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/tour_model.dart';

class AllTourScreen extends StatelessWidget {
  final PageController listController = PageController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            'Tour of the week',
            style: GoogleFonts.raleway(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600
            )
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: listController,
              itemCount: tours.length,
              itemBuilder: (BuildContext context, int index){
                Tour tour = tours[index];
                Image tourImg = Image.asset(tour.img);
                return TourItemForAll(tour: tour, tourImg: tourImg,);
              }),
        ),
      ),
    );
  }
}

