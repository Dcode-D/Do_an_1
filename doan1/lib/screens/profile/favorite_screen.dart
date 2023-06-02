import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/hotel_model.dart';
import '../../models/tour_model.dart';
import '../../models/vehicle_model.dart';
import '../../widgets/circle_indicator.dart';
import '../../widgets/silver_appbar_delegate.dart';
import '../all/all_widget/hotel_item_for_all.dart';
import '../all/all_widget/tour_item_for_all.dart';
import '../all/all_widget/vehicle_item_for_all.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with SingleTickerProviderStateMixin{
  final ScrollController _scrollController = ScrollController();
  final PageController listController = PageController();
  late final TabController _tabController = TabController(length: 3, vsync: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Favorite',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: listController,
                  itemCount: tours.length,
                  itemBuilder: (BuildContext context, int index){
                    Tour tour = tours[index];
                    Image tourImg = Image.asset(tour.img);
                    return TourItemForAll(tour: tour, tourImg: tourImg,);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: listController,
                  itemCount: hotels.length,
                  itemBuilder: (BuildContext context, int index){
                    Hotel hotel = hotels[index];
                    Image hotelImg = Image.asset(hotel.imageUrl);
                    return HotelItemForAll();
                  }
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
          ],
        ),
      )
    );
  }
}