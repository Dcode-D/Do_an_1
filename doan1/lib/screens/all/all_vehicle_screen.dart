import 'package:doan1/screens/all/all_widget/vehicle_item_for_all.dart';
import 'package:flutter/material.dart';

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
          title: const Text(
            'Vehicle for you',
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
            itemCount: vehicles.length,
            itemBuilder: (BuildContext context, int index){
              Vehicle vehicle = vehicles[index];
              Image vehicleImg = Image.asset(vehicle.imageUrl);
              return VehicleItemForAll(vehicle: vehicle, vehicleImg: vehicleImg);
            }
        ),
      )
    );
  }
}