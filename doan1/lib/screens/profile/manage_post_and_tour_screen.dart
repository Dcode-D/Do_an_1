import 'package:doan1/screens/profile/floating_button/widget/post/edit_post_item.dart';
import 'package:doan1/screens/profile/floating_button/widget/tour/edit_tour_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/hotel_model.dart';
import '../../models/vehicle_model.dart';
import '../../widgets/circle_indicator.dart';
import '../../widgets/silver_appbar_delegate.dart';

class ManagePostAndTourScreen extends StatefulWidget {
  const ManagePostAndTourScreen({Key? key}) : super(key: key);

  @override
  _ManagePostAndTourScreenState createState() => _ManagePostAndTourScreenState();
}

class _ManagePostAndTourScreenState extends State<ManagePostAndTourScreen> with SingleTickerProviderStateMixin{
  final ScrollController _scrollController = ScrollController();
  late final TabController _tabController = TabController(length: 2, vsync: this);
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
                      Tab(text: 'Destination',),
                      Tab(text: 'Tour',)
                    ],
                  ),
                )),
          ];
        },
        body: TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 70),
                itemCount: hotels.length,
                itemBuilder: (BuildContext context, int index) {
                  return EditPostItem();
                },
              ),
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                itemCount: vehicles.length,
                itemBuilder: (BuildContext context, int index) {
                  return EditTourItem();
                },
              ),
            ]
        ),
      ),
    );
  }
}