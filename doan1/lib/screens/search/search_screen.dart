import 'package:doan1/widgets/hotel_item.dart';
import 'package:doan1/widgets/salomon_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../models/hotel_model.dart';
import '../../models/tour_model.dart';
import '../../widgets/circle_indicator.dart';
import '../../widgets/silver_appbar_delegate.dart';
import '../../widgets/tour_item.dart';

class SearchScreen extends StatefulWidget {

  const SearchScreen({Key? key})
      : super(key: key);

  @override
  createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  var _searchController = TextEditingController();
  late TabController _tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, value) {
      return [
        SliverAppBar(
          centerTitle: false,
          floating: true,
          pinned: true,
          snap: false,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          expandedHeight: MediaQuery.of(context).size.height * 0.25,
          flexibleSpace: const FlexibleSpaceBar(
            background: Image(
              image: AssetImage('assets/images/search-background.jpg'),
              fit: BoxFit.cover,
            ),),
          bottom: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Center(
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                    .scaffoldBackgroundColor
                    .withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search ...',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15, top: 14),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ), suggestionsCallback: (String pattern) {
                      //TODO: implement suggestionsCallback for data
                      return [
                        'suggestion 1',
                        'suggestion 2',
                        'suggestion 3',
                        'suggestion 4',
                      ];
                  },
                    itemBuilder: (BuildContext context, String? itemData) {
                      return ListTile(
                        title: Text(itemData!),
                      );
                    },
                    onSuggestionSelected: (String? suggestion) {
                      _searchController.text = suggestion!;
                    },
                  )
                ),
              ),
            ),
          )
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
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
          itemCount: tours.length,
          itemBuilder: (BuildContext context, int index) {
          Tour tour = tours[index];
          Image tourImg = Image.asset(tour.img);
          return TourItem(tour: tour, tourImg: tourImg, type: 2);
          },
        ),
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 70),
            itemCount: hotels.length,
            itemBuilder: (BuildContext context, int index) {
              Hotel hotel = hotels[index];
              Image hotelImg = Image.asset(hotel.imageUrl);
              return HotelItem(hotel: hotel, hotelImg: hotelImg, type: 2);
            },
          ),
        ],
      )
      ),
    );
  }
}