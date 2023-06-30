import 'package:doan1/screens/booking/booking_screen.dart';
import 'package:doan1/screens/home/home_screen.dart';
import 'package:doan1/screens/profile/profile_screen.dart';
import 'package:doan1/screens/search/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../BLOC/navigation/navigation_bloc.dart';
import '../BLOC/profile/profile_view/profile_bloc.dart';
import '../BLOC/screen/all_screen/all_hotel/all_hotel_bloc.dart';
import '../BLOC/screen/all_screen/all_vehicle/all_vehicle_bloc.dart';
import '../BLOC/screen/all_screen/article/article_bloc.dart';
import '../BLOC/screen/book_history/book_history_bloc.dart';
import '../BLOC/screen/home/home_bloc.dart';
import '../BLOC/screen/search/search_bloc.dart';

class NavigationNavBar extends StatelessWidget {
  int current_tab = 0;

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<ProfileBloc>();
    bloc.add(getProfileScreenEvent());

    return Builder(
        builder: (context) =>
            BlocProvider(
                create: (context) => NavigationBloc(),
                child: Scaffold(
                  extendBody: true,
                  body: BlocBuilder<NavigationBloc, NavigationInfoState>(
                    builder: (context, state) {
                      switch (state.selectedIndex) {
                        case 0:
                          return
                            MultiBlocProvider(
                              providers: [
                                BlocProvider<HomeBloc>(
                                    create: (context) =>
                                    HomeBloc()
                                      ..add(GetDataForScreenEvent())),
                                BlocProvider<AllHotelBloc>(
                                    create: (context) =>
                                    AllHotelBloc()
                                      ..add(GetHotelListEvent())),
                                BlocProvider<AllVehicleBloc>(
                                    create: (context) =>
                                    AllVehicleBloc()
                                      ..add(GetVehicleListEvent())),
                                BlocProvider<ArticleBloc>(
                                    create: (context) =>
                                    ArticleBloc()
                                      ..add(GetArticleData())),
                                BlocProvider<BookHistoryBloc>(
                                    create: (context) =>
                                        BookHistoryBloc()),
                              ],
                              child: Builder(builder: (context) {
                                return HomeScreen();
                              }),
                            );
                        case 1:
                          return
                            SearchScreen();

                        case 2:
                          return
                            MultiBlocProvider(
                              providers: [
                                BlocProvider<BookHistoryBloc>(
                                    create: (context) =>
                                        BookHistoryBloc()),
                              ],
                              child: Builder(builder: (context) {
                                return BookingScreen();
                              }),
                            );
                        case 3:
                          return
                            ProfileScreen();
                        default:
                          return
                            Center(
                                child: Text('Error'));
                      }
                    }
                  ),
                  bottomNavigationBar: Salomon_nav_bar(),
                )));
  }

}

class Salomon_nav_bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationInfoState>(
        builder: (context, state) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            height: 70,
            child: Wrap(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: SalomonBottomBar(
                      currentIndex: state.selectedIndex,
                      onTap: (index) {
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigateEvent(selectedIndex: index));
                      },
                      selectedItemColor: Colors.orange,
                      unselectedItemColor: Colors.grey,
                      items: [
                        // Home tab
                        SalomonBottomBarItem(
                          icon: const ImageIcon(
                            AssetImage('assets/icons/icon-home-outline.png'),
                            size: 28.0,
                          ),
                          activeIcon: const ImageIcon(
                            AssetImage('assets/icons/icon-home-fill.png'),
                            size: 28.0,
                          ),
                          title: const Text(
                            'Home',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        // Search tab
                        SalomonBottomBarItem(
                          icon: const ImageIcon(
                            AssetImage('assets/icons/icon-search.png'),
                            size: 28.0,
                          ),
                          title: const Text(
                            'Search',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        // Booking tab
                        SalomonBottomBarItem(
                          icon: const ImageIcon(
                            AssetImage('assets/icons/icon-booking-outline.png'),
                            size: 28.0,
                          ),
                          activeIcon: const ImageIcon(
                            AssetImage('assets/icons/icon-booking-fill.png'),
                            size: 28.0,
                          ),
                          title: const Text(
                            'Booking',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        // Profile tab
                        SalomonBottomBarItem(
                          icon: const ImageIcon(
                            AssetImage('assets/icons/icon-person-outline.png'),
                            size: 28.0,
                          ),
                          activeIcon: const ImageIcon(
                            AssetImage('assets/icons/icon-person-fill.png'),
                            size: 28.0,
                          ),
                          title: const Text(
                            'Profile',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
