import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/vehicle_model.dart';
import '../screens/detail_screens/vehicle/vehicle_rent_detail_screen.dart';

class VehicleItem extends StatelessWidget{
  @override
    final Vehicle vehicle;
    final Image vehicleImg;
    final int type;

    VehicleItem({
      Key? key,
      required this.vehicle,
      required this.vehicleImg,
      required this.type
    }) : super(key: key);

    final formatCurrency = NumberFormat("#,###");

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: type == 1 ? 280 : 300,
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => VehicleRentDetailScreen(
              vehicle: vehicle,
              vehicleImg: vehicleImg,
              type: type,
            ),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(10.0),
          width: type == 1 ? 240.0 : 260.0,
          height: type == 1 ? 260.0 : 265.0,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Positioned(
                bottom: 0.0,
                child: Container(
                  height: type == 1 ? 120.0 : 150.0,
                  width: type == 1 ? 240.0 : 320.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          vehicle.name,
                          style: TextStyle(
                            fontSize: type == 1 ? 18.0 : 20.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          vehicle.address,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          '${formatCurrency.format(int.parse(vehicle.price))}\$ / day',
                          style: TextStyle(
                            fontSize: type == 1 ? 18.0 : 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                    height: type == 1 ? 180.0 : 185.0,
                    width: type == 1 ? 220.0 : 260.0,
                    image: AssetImage(vehicle.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}