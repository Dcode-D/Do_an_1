import 'package:doan1/BLOC/screen/all_screen/all_vehicle/all_vehicle_bloc.dart';
import 'package:doan1/BLOC/widget_item/car_item/car_item_bloc.dart';
import 'package:doan1/screens/all/all_widget/vehicle_item_for_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BLOC/profile/profile_view/profile_bloc.dart';
import '../../BLOC/screen/book_history/book_history_bloc.dart';

class AllVehicleScreen extends StatelessWidget{
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var allVehicleBloc = context.read<AllVehicleBloc>();
    var profileBloc = context.read<ProfileBloc>();
    var bookHistoryBloc = context.read<BookHistoryBloc>();
    int page = 1;

    scrollController.addListener((){
      if (allVehicleBloc.state.isLoadingMore == true && scrollController.position.pixels == scrollController.position.maxScrollExtent){
        return;
      }
      else
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        page=page+1;
        allVehicleBloc.add(GetVehicleListExtraEvent(page: page));
      }
    });

    return BlocListener<AllVehicleBloc,AllVehicleState>(
      listener: (context,state){
        if(state.maxData == true){
          SmartDialog.showToast('No more data', displayTime: const Duration(milliseconds: 1000));
        }
      },
      child: BlocBuilder<AllVehicleBloc,AllVehicleState>(
        builder: (context,state) =>
         SafeArea(
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
                  'Vehicle for you',
                  style: GoogleFonts.raleway(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600
                  )
                ),
              ),
            body: state.getListVehicleSuccess == true
               ?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    itemCount: state.isLoadingMore ? allVehicleBloc.listVehicle!.length + 1 : allVehicleBloc.listVehicle!.length,
                    itemBuilder: (BuildContext context, int index){
                      if(index < allVehicleBloc.listVehicle!.length){
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider<ProfileBloc>.value(value: profileBloc),
                            BlocProvider<BookHistoryBloc>.value(value: bookHistoryBloc),
                          ],
                            child: BlocProvider<CarItemBloc>(
                              create: (context) => CarItemBloc()..add(GetCarItemEvent(vehicleId: allVehicleBloc.listVehicle![index].id!)),
                                child: VehicleItemForAll(type: 1,)));
                      }
                      else{
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      }
                    }
                ),
            ) :
            const Center(
              child: CircularProgressIndicator(),
            ),
        ),
         ),
      ),
    );
  }
}