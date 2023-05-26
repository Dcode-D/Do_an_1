import 'package:doan1/screens/all/all_widget/vehicle_item_for_all.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/vehicle_model.dart';

class AllVehicleScreen extends StatelessWidget{
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
          title: Text(
            'Vehicle for you',
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
            itemCount: vehicles.length,
            itemBuilder: (BuildContext context, int index){
              Vehicle vehicle = vehicles[index];
              Image vehicleImg = Image.asset(vehicle.imageUrls[0]);
              return VehicleItemForAll(vehicle: vehicle, vehicleImg: vehicleImg);
            }
        ),
      )
    );
  }
}