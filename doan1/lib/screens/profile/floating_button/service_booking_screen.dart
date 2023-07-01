import 'package:doan1/BLOC/profile/edit_hotel/edit_hotel_item_bloc.dart';
import 'package:doan1/BLOC/profile/manage_hotel_car/manage_service_bloc.dart';
import 'package:doan1/BLOC/profile/profile_view/profile_bloc.dart';
import 'package:doan1/screens/profile/check_booking/widget/booking_hotel_item.dart';
import 'package:doan1/screens/profile/check_booking/widget/booking_vehicle_item.dart';
import 'package:doan1/screens/profile/floating_button/widget/hotel/edit_hotel_item.dart';
import 'package:doan1/screens/profile/floating_button/widget/vehicle/edit_vehicle_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../BLOC/profile/edit_vehicle/edit_vehicle_item_bloc.dart';
import '../../../data/model/hotel.dart';
import '../../../widgets/circle_indicator.dart';
import '../../../widgets/silver_appbar_delegate.dart';

class ServiceBookingScreen extends StatefulWidget {
  const ServiceBookingScreen({Key? key}) : super(key: key);

  @override
  _ManageServiceScreenState createState() => _ManageServiceScreenState();
}

class _ManageServiceScreenState extends State<ServiceBookingScreen> with SingleTickerProviderStateMixin{
  final ScrollController _scrollController = ScrollController();
  final ScrollController _HotelScrollController = ScrollController();
  final ScrollController _VehicleScrollController = ScrollController();
  late ProfileBloc profileBloc;
  late ManageServiceBloc manageServiceBloc;
  @override
  initState() {
    super.initState();
    profileBloc = context.read<ProfileBloc>();
    manageServiceBloc = context.read<ManageServiceBloc>();
    _HotelScrollController.addListener(() {
      if (_HotelScrollController.position.pixels ==
          _HotelScrollController.position.maxScrollExtent) {
        hotelPage++;
        manageServiceBloc.add(LoadMoreHotelData(profileBloc.user!.id,hotelPage));
      }
    });

    _VehicleScrollController.addListener(() {
      if (_VehicleScrollController.position.pixels ==
          _VehicleScrollController.position.maxScrollExtent) {
        vehiclePage++;
        manageServiceBloc.add(LoadMoreVehicleData(profileBloc.user!.id,vehiclePage));
      }
    });
  }
  int hotelPage = 1;
  int vehiclePage = 1;
  late final TabController _tabController = TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageServiceBloc,ManageServiceState>(
      listenWhen: (previous, current) {
        return current is GetInitialDataState ||
            current is LoadMoreHotelDataState ||
            current is LoadMoreVehicleDataState ||
            current is DeleteVehicleItemState ||
            current is DeleteHotelItemOnManageState
        ;},
      listener: (context,state){
        print("triggered listener!");
        if(state is GetInitialDataState){
          if(state.getDataSuccess == false){
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Get data failed')));
          }
          else{
            hotelPage = 1;
            vehiclePage = 1;
          }
        }
        if (state is LoadMoreHotelDataState) {
          if (state.getDataSuccess == false) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No more hotel for you.')));
          }
        }
        if (state is LoadMoreVehicleDataState) {
          if (state.getDataSuccess == false) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No more vehicle for you.')));
          }
        }
        if(state is DeleteVehicleItemState){
          if(state.isDeleted == false){
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Delete vehicle failed')));
          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Delete vehicle success')));
          }
        }

        if(state is DeleteHotelItemOnManageState){
          if(state.isDeleted == false){
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Delete hotel failed')));
          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Delete hotel success')));
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
            body: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, value) {
                return [
                  SliverAppBar(
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                    centerTitle: true,
                    floating: true,
                    pinned: true,
                    snap: false,
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    title: Text(
                      'Bookings of services',
                      style: GoogleFonts.raleway(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                      delegate: SliverAppBarDelegate(
                        color: Colors.transparent,
                        tabbar: TabBar(
                          controller: _tabController,
                          isScrollable: false,
                          labelColor: Colors.black87,
                          unselectedLabelColor: Colors.grey,
                          labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                          labelStyle: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                          unselectedLabelStyle: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                          indicator: CircleTabIndicator(
                            color: Colors.orange,
                            radius: 4,
                          ),
                          tabs: const [
                            Tab(text: 'Hotel',),
                            Tab(text: 'Vehicle',)
                          ],
                        ),
                      )),
                ];
              },
              body:
              BlocBuilder<ManageServiceBloc,ManageServiceState>(
                  builder: (context,state) {
                    print("triggered builder!");
                    return
                      TabBarView(
                          controller: _tabController,
                          children: [
                            manageServiceBloc.listHotel != null ?
                            ListView.builder(
                              key: const PageStorageKey('hotel'),
                              addAutomaticKeepAlives: true,
                              controller: _HotelScrollController,
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 70),
                              itemCount: context.read<ManageServiceBloc>().listHotel!.length,
                              itemBuilder: (BuildContext context, int index) {
                                Hotel hotel = manageServiceBloc.listHotel![index];
                                return MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(value: manageServiceBloc),
                                    BlocProvider.value(value: profileBloc),
                                  ],
                                  child: BlocProvider<EditHotelItemBloc>(
                                      create: (context) => EditHotelItemBloc()..add(GetHotelItemEvent(hotel: hotel)),
                                      child: BookingHotelItem()),
                                );
                              },
                            ) :
                            const Center(child: Text('You don\'t have any hotel')),
                            manageServiceBloc.listVehicle != null ?
                            ListView.builder(
                              key: const PageStorageKey('vehicle'),
                              addAutomaticKeepAlives: true,
                              controller: _VehicleScrollController,
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                              itemCount: manageServiceBloc.listVehicle!.length,
                              itemBuilder: (BuildContext context, int index) {
                                String vehicle = manageServiceBloc.listVehicle![index].id!;
                                return MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(value: manageServiceBloc),
                                      BlocProvider.value(value: profileBloc),
                                    ],
                                    child: BlocProvider<EditVehicleItemBloc>(
                                        create: (context) => EditVehicleItemBloc()..add(GetVehicleItemEvent(vehicleId: vehicle)),
                                        child: BookingVehicleItem()));
                              },
                            ):
                            const Center(child: Text('You don\'t have any vehicle'))
                          ]
                      );}
              ),
            )
        ),
      ),
    );
  }
}