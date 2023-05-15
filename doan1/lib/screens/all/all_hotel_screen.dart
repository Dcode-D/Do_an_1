import 'package:doan1/screens/all/all_widget/hotel_item_for_all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/hotel_model.dart';

class AllHotelScreen extends StatelessWidget{
  final PageController listController = PageController();
  @override
  Widget build(BuildContext context) {
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
          title: const Text(
            'Hotels for you',
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
            itemCount: hotels.length,
            itemBuilder: (BuildContext context, int index){
              Hotel hotel = hotels[index];
              Image hotelImg = Image.asset(hotel.imageUrl);
              return HotelItemForAll(hotel: hotel, hotelImg: hotelImg);
            }
        ),
      )
    );
  }

}