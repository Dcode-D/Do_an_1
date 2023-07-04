import 'package:doan1/BLOC/screen/book_history/book_history_bloc.dart';
import 'package:doan1/screens/booking/widget_booking/hotel_booking_item.dart';
import 'package:doan1/screens/booking/widget_booking/vehicle_booking_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BLOC/profile/profile_view/profile_bloc.dart';
import '../../BLOC/screen/booking_widget/hotel_booking_item/hotel_booking_item_bloc.dart';
import '../../BLOC/screen/booking_widget/vehicle_booking_item/vehicle_booking_item_bloc.dart';
import '../../widgets/circle_indicator.dart';
import '../../widgets/silver_appbar_delegate.dart';

class BookingScreen extends StatefulWidget {

  const BookingScreen({Key? key})
      : super(key: key);

  @override
  createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final hotelBookingController = ScrollController();
  final vehicleBookingController = ScrollController();
  late final TabController _tabController = TabController(length: 2, vsync: this);
  int hotelPage = 1;
  int vehiclePage = 1;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(LifecycleEventHandler(
      resumeCallBack: ()async {
        context.read<BookHistoryBloc>().add(RefreshBookingHistoryEvent());
      },
    ));
    hotelBookingController.addListener(() {
      if (hotelBookingController.position.pixels ==
          hotelBookingController.position.maxScrollExtent) {
        context.read<BookHistoryBloc>().add(GetNextHotelBooking());
      }
    });

    vehicleBookingController.addListener(() {
      if (vehicleBookingController.position.pixels ==
          vehicleBookingController.position.maxScrollExtent) {
        context.read<BookHistoryBloc>().add(GetNextVehicleBooking());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ProfileBloc profileBloc = context.read<ProfileBloc>();
    BookHistoryBloc bookHistoryBloc = context.read<BookHistoryBloc>();
    bookHistoryBloc.add(GetNextVehicleBooking());
    bookHistoryBloc.add(GetNextHotelBooking());
    return SafeArea(
      child: Scaffold(
      body: NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, value) {
      return [
      SliverAppBar(
        leading: const Icon(
          FontAwesomeIcons.planeArrival,
          color: Colors.white,
        ),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                FontAwesomeIcons.car,
                color: Colors.white,
              ),
            ),
          ],
          centerTitle: true,
          floating: true,
          pinned: true,
          snap: false,
          backgroundColor: Colors.white,
          flexibleSpace: Container(
          decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment(0.8, 1),
        colors: <Color>[
        Color(0xffe16b5c),
        Color(0xfff39060),
        Color(0xffffb56b),
        ], // Gradient from https://learnui.design/tools/gradient-generator.html
        tileMode: TileMode.mirror,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            'Your booking history',
            style: GoogleFonts.raleway(
              fontSize: 20,
              color: Colors.white,
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
                Tab(text: 'Hotel'),
                Tab(text: 'Vehicle',)
              ],
            ),
          )),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: [
          BlocListener<BookHistoryBloc,BookHistoryState>(
            listenWhen: (previous, current) => current is BookHistoryInitial,
            listener: (context, state) {
              if (state is BookHistoryInitial) {
                if (state.isBookingHistoryLoaded == true) {
                  hotelPage = 1;
                  vehiclePage = 1;
                }
              }
            },
            child: BlocBuilder<BookHistoryBloc,BookHistoryState>(
              buildWhen: (previous, current) =>
              current is BookHistoryInitial && current.isBookingHistoryLoaded == true,
              builder:(context,state) =>
              state is BookHistoryInitial ?
                state.isBookingHistoryLoaded == true ?
                    bookHistoryBloc.lsHotelBooking!.isEmpty ?
                    Center(
                      child:
                      Text('No hotel booking history',
                        style: GoogleFonts.raleway(
                          fontSize: 20,
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w600
                          )))
                      :
                    ListView.builder(
                      key: UniqueKey(),
                      controller: hotelBookingController,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 70),
                      itemCount: bookHistoryBloc.lsHotelBooking!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider<ProfileBloc>.value(
                              value: profileBloc),
                            BlocProvider<HotelBookingItemBloc>(
                              create: (context) => HotelBookingItemBloc()..add(
                                  HotelBookingItemInitialEvent(dateBooking: bookHistoryBloc.lsHotelBooking![index],index: index)),
                            ),
                            BlocProvider<BookHistoryBloc>.value(
                              value: bookHistoryBloc),
                          ],
                            child: HotelBookingItem());
                      },)
                  :
                Center(
                    child:
                    Text('No hotel booking history',
                        style: GoogleFonts.raleway(
                            fontSize: 20,
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w600
                        ))) :
              const Center(child: CircularProgressIndicator(),)
            ),
          ),

          BlocBuilder<BookHistoryBloc,BookHistoryState>(
            buildWhen: (previous, current) =>
            current is BookHistoryInitial && current.isBookingHistoryLoaded == true,
            builder:(context,state) =>
            state is BookHistoryInitial ?
              state.isBookingHistoryLoaded == true ?
                bookHistoryBloc.lsVehicleBooking!.isEmpty ?
                  Center(child:
                    Text('No vehicle booking history',
                      style: GoogleFonts.raleway(
                          fontSize: 20,
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w600
                      ),
                    )
                  )
                    :
                  ListView.builder(
                    controller: vehicleBookingController,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                    itemCount: bookHistoryBloc.lsVehicleBooking!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        key: UniqueKey(),
                        child: MultiBlocProvider(
                          providers: [
                            BlocProvider<ProfileBloc>.value(
                                value: profileBloc),
                            BlocProvider<VehicleBookingItemBloc>(
                                create: (context) => VehicleBookingItemBloc()..add(
                                    VehicleBookingItemInitialEvent(dateBooking: bookHistoryBloc.lsVehicleBooking![index],index: index))
                            ),
                            BlocProvider<BookHistoryBloc>.value(
                                value: bookHistoryBloc),
                          ],
                            child: VehicleBookingItem()),
                      );},)
                  :
              Center(child:
              Text('No vehicle booking history',
                style: GoogleFonts.raleway(
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w600
                ),
              )
              )
              :
            const Center(child: CircularProgressIndicator(),),
          )
        ],
      ),
          )
        ),
    );
  }
}


class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback? resumeCallBack;
  final AsyncCallback? suspendingCallBack;

  LifecycleEventHandler({
    this.resumeCallBack,
    this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    print("Change state detected");
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          await resumeCallBack!();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (suspendingCallBack != null) {
          await suspendingCallBack!();
        }
        break;
    }
  }
}