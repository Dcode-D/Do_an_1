import 'package:doan1/screens/booking/widget_booking/hotel_booking_item.dart';
import 'package:doan1/screens/booking/widget_booking/tour_booking_item.dart';
import 'package:doan1/screens/booking/widget_booking/vehicle_booking_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/hotel_model.dart';
import '../../models/tour_model.dart';
import '../../models/vehicle_model.dart';
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
  late TabController _tabController = TabController(length: 3, vsync: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              style: GoogleFonts.roboto(
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
                  Tab(text: 'Tour'),
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
            //TODO: Need to do list of orders
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
              itemCount: tours.length,
              itemBuilder: (BuildContext context, int index) {
                return TourBookingItem();
              },
            ),
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 70),
              itemCount: hotels.length,
              itemBuilder: (BuildContext context, int index) {
                return HotelBookingItem();
              },
            ),
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
              itemCount: vehicles.length,
              itemBuilder: (BuildContext context, int index) {
                return VehicleBookingItem();
              },
            ),
          ],
        ),
      )
    );
  }
}