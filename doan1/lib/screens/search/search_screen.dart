import 'package:doan1/BLOC/screen/search/search_bloc.dart';
import 'package:doan1/BLOC/widget_item/car_item/car_item_bloc.dart';
import 'package:doan1/BLOC/widget_item/hotel_item/hotel_item_bloc.dart';
import 'package:doan1/widgets/hotel_item.dart';
import 'package:doan1/widgets/vehicle_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BLOC/profile/profile_view/profile_bloc.dart';
import '../../BLOC/screen/book_history/book_history_bloc.dart';
import '../../BLOC/widget_item/tour_item/tour_item_bloc.dart';
import '../../data/model/vehicle.dart';
import '../../models/tour_model.dart';
import '../../widgets/circle_indicator.dart';
import '../../widgets/silver_appbar_delegate.dart';
import '../../widgets/tour_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final _searchController = TextEditingController();
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SearchBloc>(create: (context) => SearchBloc()),
          BlocProvider<BookHistoryBloc>(create: (context) => BookHistoryBloc()),
        ],
        child: Builder(builder: (context) {
          var searchBloc = context.read<SearchBloc>()..add(GetInitialData());
          var profileBloc = context.read<ProfileBloc>();
          var bookHistoryBloc = context.read<BookHistoryBloc>();
          return BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) => SafeArea(
                    child: Scaffold(
                      body: GestureDetector(
                        onTap: () =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        child: NestedScrollView(
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
                                  expandedHeight:
                                      MediaQuery.of(context).size.height * 0.25,
                                  flexibleSpace: const FlexibleSpaceBar(
                                    background: Image(
                                      image: AssetImage(
                                          'assets/images/search-background.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
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
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                            child: TypeAheadField(
                                          textFieldConfiguration:
                                              TextFieldConfiguration(
                                            controller: _searchController,
                                            onSubmitted: (value) {
                                              if (value.isNotEmpty) {
                                                if (_tabController.index == 0) {
                                                } else if (_tabController
                                                        .index ==
                                                    1) {
                                                  searchBloc.add(
                                                      GetHotelForSearch(
                                                          searchText: value));
                                                } else if (_tabController
                                                        .index ==
                                                    2) {
                                                  searchBloc.add(
                                                      GetVehicleForSearch(
                                                          searchText: value));
                                                }
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                          title: const Text(
                                                              'Missing something!'),
                                                          content: const Text(
                                                              'Please enter something to search'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              child: const Text(
                                                                  'OK'),
                                                            )
                                                          ],
                                                        ));
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Search ...',
                                              hintStyle: const TextStyle(
                                                color: Colors.grey,
                                                fontStyle: FontStyle.italic,
                                                fontSize: 16,
                                              ),
                                              border: InputBorder.none,
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15, top: 14),
                                              suffixIcon: IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.search,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                          suggestionsCallback:
                                              (String pattern) {
                                            //TODO: implement suggestionsCallback for data
                                            return [
                                              'Da lat',
                                              'Lanmark 81',
                                              'Vung Tau',
                                              'Quy Nhon',
                                            ];
                                          },
                                          itemBuilder: (BuildContext context,
                                              String? itemData) {
                                            return ListTile(
                                              title: Text(itemData!),
                                            );
                                          },
                                          onSuggestionSelected:
                                              (String? suggestion) {
                                            _searchController.text =
                                                suggestion!;
                                          },
                                        )),
                                      ),
                                    ),
                                  )),
                              SliverPersistentHeader(
                                  delegate: SliverAppBarDelegate(
                                color: Colors.transparent,
                                tabbar: TabBar(
                                  controller: _tabController,
                                  isScrollable: true,
                                  labelColor: Colors.black87,
                                  unselectedLabelColor: Colors.grey,
                                  labelPadding: const EdgeInsets.symmetric(
                                      horizontal: 20),
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
                                    Tab(text: 'Vehicle')
                                  ],
                                ),
                              )),
                            ];
                          },
                          body: TabBarView(
                            controller: _tabController,
                            children: [
                              searchBloc.listTour != null
                                  ? ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 50),
                                      itemCount: searchBloc.listTour!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return MultiBlocProvider(providers: [
                                          BlocProvider.value(
                                              value: profileBloc),
                                          BlocProvider.value(value: searchBloc),
                                          BlocProvider<TourItemBloc>(
                                              create: (context) =>
                                                  TourItemBloc()
                                                    ..add(GetTourItemEvent(
                                                        tourId: searchBloc
                                                            .listTour![index]
                                                            .id!))),
                                        ], child: TourItem(type: 2));
                                      },
                                    )
                                  : Center(
                                      child: Text(
                                        'Don\'t found any tour that like your search',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.raleway(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey),
                                      ),
                                    ),
                              searchBloc.listHotel != null
                                  ? ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 70),
                                      itemCount: searchBloc.listHotel!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return MultiBlocProvider(
                                            providers: [
                                              BlocProvider.value(
                                                  value: profileBloc),
                                              BlocProvider.value(
                                                  value: searchBloc),
                                              BlocProvider.value(
                                                  value: bookHistoryBloc)
                                            ],
                                            child: BlocProvider<HotelItemBloc>(
                                                create: (context) =>
                                                    HotelItemBloc()
                                                      ..add(GetHotelItemEvent(
                                                          hotelId: searchBloc
                                                              .listHotel![index]
                                                              .id)),
                                                child: HotelItem(type: 2)));
                                      },
                                    )
                                  : Center(
                                      child: Text(
                                          'Don\'t found any hotel that like your search',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.raleway(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey)),
                                    ),
                              searchBloc.listVehicle != null
                                  ? ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 70),
                                      itemCount: searchBloc.listVehicle!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Vehicle vehicle =
                                            searchBloc.listVehicle![index];
                                        return MultiBlocProvider(
                                            providers: [
                                              BlocProvider.value(
                                                  value: profileBloc),
                                              BlocProvider.value(
                                                  value: searchBloc),
                                              BlocProvider.value(
                                                  value: bookHistoryBloc)
                                            ],
                                            child: BlocProvider<CarItemBloc>(
                                                create: (context) =>
                                                    CarItemBloc()
                                                      ..add(GetCarItemEvent(
                                                          vehicleId: searchBloc
                                                              .listVehicle![
                                                                  index]
                                                              .id!)),
                                                child: VehicleItem(type: 2)));
                                      },
                                    )
                                  : Center(
                                      child: Text(
                                          'Don\'t found any vehicle that like your search',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.raleway(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey)),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ));
        }));
  }
}
