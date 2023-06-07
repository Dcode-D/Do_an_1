import 'package:doan1/BLOC/profile/edit_hotel/edit_hotel_item_bloc.dart';
import 'package:doan1/BLOC/profile/manage_hotel_car/manage_service_bloc.dart';
import 'package:doan1/BLOC/profile/profile_view/profile_bloc.dart';
import 'package:doan1/screens/profile/floating_button/widget/hotel/edit_hotel_item.dart';
import 'package:doan1/screens/profile/floating_button/widget/vehicle/edit_vehicle_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../BLOC/profile/edit_vehicle/edit_vehicle_item_bloc.dart';
import '../../../data/model/hotel.dart';
import '../../../data/model/vehicle.dart';
import '../../../widgets/circle_indicator.dart';
import '../../../widgets/silver_appbar_delegate.dart';

class ManageServiceScreen extends StatefulWidget {
  const ManageServiceScreen({Key? key}) : super(key: key);

  @override
  _ManageServiceScreenState createState() => _ManageServiceScreenState();
}

class _ManageServiceScreenState extends State<ManageServiceScreen> with SingleTickerProviderStateMixin{
  final ScrollController _scrollController = ScrollController();
  late final TabController _tabController = TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    var profileBloc = BlocProvider.of<ProfileBloc>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageServiceBloc>(
          create: (context) => ManageServiceBloc()..add(GetDataByOwner(profileBloc.user!.id)),
        ),
      ],
      child: BlocListener<ManageServiceBloc,ManageServiceState>(
        listener: (context,state){
          if(state is GetInitialDataState){
            if(state.getDataSuccess == false){
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Get data failed')));
            }
          }
        },
        child: Scaffold(
            body: BlocBuilder<ProfileBloc,ProfileState>(
              builder: (context,state) =>
              NestedScrollView(
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
                        'Manage Service',
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
                            isScrollable: true,
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
                  builder: (context,state) =>
                  TabBarView(
                      controller: _tabController,
                      children: [
                        context.read<ManageServiceBloc>().listHotel != null ?
                        ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 70),
                          itemCount: context.read<ManageServiceBloc>().listHotel!.length,
                          itemBuilder: (BuildContext context, int index) {
                            Hotel hotel = context.read<ManageServiceBloc>().listHotel![index];
                            return BlocProvider<EditHotelItemBloc>(
                              create: (context) => EditHotelItemBloc()..add(GetHotelItemEvent(hotel)),
                                child: EditHotelItem());
                          },
                        ) :
                        const Center(child: Text('You don\'t have any hotel')),
                        context.read<ManageServiceBloc>().listVehicle != null ?
                        ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                          itemCount: context.read<ManageServiceBloc>().listVehicle!.length,
                          itemBuilder: (BuildContext context, int index) {
                            Vehicle vehicle = context.read<ManageServiceBloc>().listVehicle![index];
                            return BlocProvider<EditVehicleItemBloc>(
                                create: (context) => EditVehicleItemBloc()..add(GetVehicleItemEvent(vehicle)),
                                child: EditVehicleItem());
                          },
                        ):
                        const Center(child: Text('You don\'t have any vehicle')),
                      ]
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }

}