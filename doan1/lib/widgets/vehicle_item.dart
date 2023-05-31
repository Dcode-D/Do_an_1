import 'package:doan1/BLOC/widget_item/car_item/car_item_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../data/model/vehicle.dart';
import '../screens/detail_screens/vehicle/vehicle_rent_detail_screen.dart';

class VehicleItem extends StatelessWidget{
  @override
    final int type;

    VehicleItem({
      Key? key,
      required this.type
    }) : super(key: key);

    final formatCurrency = NumberFormat("#,###");

  @override
  Widget build(BuildContext context){
    var carItemBloc = context.read<CarItemBloc>();
    return BlocBuilder<CarItemBloc,CarItemState>(
      builder: (context,state)
      => SizedBox(
        height: type == 1 ? 280 : 300,
        child: GestureDetector(
          onTap: () {},
          // => Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (_) => VehicleRentDetailScreen(
          //       vehicle: vehicle,
          //       vehicleImg: vehicleImg,
          //       type: type,
          //     ),
          //   ),
          // ),
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
                            carItemBloc.vehicle!=null? carItemBloc.vehicle!.brand as String :"loading...",
                            style: TextStyle(
                              fontSize: type == 1 ? 18.0 : 20.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            carItemBloc.vehicle!=null? carItemBloc.vehicle!.licensePlate as String :"loading...",
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            carItemBloc.vehicle!=null? carItemBloc.vehicle!.pricePerDay.toString() :"loading...",
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
                      image: NetworkImage(carItemBloc.vehicle!=null? carItemBloc.listImage![0]: ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}