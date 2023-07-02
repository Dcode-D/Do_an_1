import 'package:doan1/BLOC/profile/favorite/favorite_bloc.dart';
import 'package:doan1/BLOC/profile/profile_view/profile_bloc.dart';
import 'package:doan1/BLOC/screen/book_history/book_history_bloc.dart';
import 'package:doan1/BLOC/widget_item/tour_item/tour_item_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BLOC/widget_item/car_item/car_item_bloc.dart';
import '../../BLOC/widget_item/hotel_item/hotel_item_bloc.dart';
import '../../models/tour_model.dart';
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
  late FavoriteBloc favoriteBloc;
  late ProfileBloc profileBloc;
  late BookHistoryBloc bookHistoryBloc;

  @override
  void initState() {
    super.initState();
    favoriteBloc = context.read<FavoriteBloc>();
    profileBloc = context.read<ProfileBloc>();
    bookHistoryBloc = context.read<BookHistoryBloc>();
    favoriteBloc.add(GetListCarFavoriteEvent(userId: profileBloc.user!.id));
    favoriteBloc.add(GetListHotelFavoriteEvent(userId: profileBloc.user!.id));
    favoriteBloc.add(GetListTourFavoriteEvent(userId: profileBloc.user!.id));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      Tab(text: 'Tour'),
                      Tab(text: 'Hotel'),
                      Tab(text: 'Vehicle',)
                    ],
                  ),
                )),
          ];
        },
          body: BlocBuilder<FavoriteBloc,FavoriteState>(
            buildWhen: (previous, current) => current is FavoriteLoaded,
            builder: (context,state) => TabBarView(
              controller: _tabController,
              children: [
                favoriteBloc.listTour != null?
                favoriteBloc.listTour!.isNotEmpty ?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: listController,
                      itemCount: favoriteBloc.listTour!.length,
                      itemBuilder: (BuildContext context, int index){
                        return MultiBlocProvider(
                          providers: [
                              BlocProvider<ProfileBloc>.value(value: profileBloc),
                              BlocProvider<TourItemBloc>(
                                  create: (context)=> TourItemBloc()..add(GetTourItemEvent(tourId: favoriteBloc.listTour![index].id)),
                              )
                            ],
                            child: TourItemForAll());
                      }),
                ) :
                const Center(child: Text("You haven't liked any tour yet.",style: TextStyle(fontSize: 20),))
                    :
                const Center(child:CircularProgressIndicator(),),
                    favoriteBloc.listHotel != null?
                    favoriteBloc.listHotel!.isNotEmpty ?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: listController,
                        itemCount: favoriteBloc.listHotel!.length,
                        itemBuilder: (BuildContext context, int index){
                          if(index < favoriteBloc.listHotel!.length){
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider<ProfileBloc>.value(value: profileBloc),
                              BlocProvider<BookHistoryBloc>.value(value: bookHistoryBloc),
                            ],
                            child: BlocProvider<HotelItemBloc>(
                                create: (context)=> HotelItemBloc()..add(GetHotelItemEvent(hotelId: favoriteBloc.listHotel![index].id)),
                                child: HotelItemForAll(type: 1,)),
                            );
                          } else{
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
                    )
                        :
                    const Center(child: Text("You haven't liked any hotel yet.",style: TextStyle(fontSize: 20),))
                        :
                    const Center(child:CircularProgressIndicator(),),
                    favoriteBloc.listCar != null?
                    favoriteBloc.listCar!.isNotEmpty ?
                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: listController,
                        itemCount: favoriteBloc.listCar!.length,
                        itemBuilder: (BuildContext context, int index){
                          if(index < favoriteBloc.listCar!.length){
                            return MultiBlocProvider(
                                providers: [
                                  BlocProvider<ProfileBloc>.value(value: profileBloc),
                                  BlocProvider<BookHistoryBloc>.value(value: bookHistoryBloc),
                                ],
                                child: BlocProvider<CarItemBloc>(
                                    create: (context) => CarItemBloc()..add(GetCarItemEvent(vehicleId: favoriteBloc.listCar![index].id!)),
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
                  )
                    :
                  const Center(child: Text("You haven't liked any vehicle yet.",style: TextStyle(fontSize: 20),))
                    :
                const Center(child:CircularProgressIndicator(),),
              ],
            ),
          ),
        )
      ),
    );
  }
}