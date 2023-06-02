import 'package:doan1/BLOC/screen/all_screen/all_vehicle/all_vehicle_bloc.dart';
import 'package:doan1/BLOC/widget_item/car_item/car_item_bloc.dart';
import 'package:doan1/screens/all/all_widget/vehicle_item_for_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BLOC/profile/profile_view/profile_bloc.dart';
import '../../data/model/vehicle.dart';

class AllVehicleScreen extends StatelessWidget{
  final ScrollController listController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var allVehicleBloc = context.read<AllVehicleBloc>();
    var profileBloc = context.read<ProfileBloc>();
    return BlocBuilder<AllVehicleBloc,AllVehicleState>(
      builder: (context,state) =>
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
              'Vehicle for you',
              style: GoogleFonts.raleway(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600
              )
            ),
          ),
        body: state.getListVehicleSuccess == true ?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: listController,
                itemCount: allVehicleBloc.listVehicle!.length,
                itemBuilder: (BuildContext context, int index){
                  Vehicle vehicle = allVehicleBloc.listVehicle![index];
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<AllVehicleBloc>.value(value: allVehicleBloc),
                      BlocProvider<ProfileBloc>.value(value: profileBloc),
                    ],
                      child: BlocProvider<CarItemBloc>(
                        create: (context) => CarItemBloc()..add(GetCarItemEvent(vehicle: vehicle)),
                          child: VehicleItemForAll(type: 1,)));
                }
            ),
        ) :
        const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}