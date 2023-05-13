import 'package:doan1/screens/all/all_widget/tour_item_for_all.dart';
import 'package:flutter/material.dart';

import '../../models/tour_model.dart';

class AllTourScreen extends StatelessWidget {
  final PageController listController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Tour of the week',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
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
    );
  }
}

