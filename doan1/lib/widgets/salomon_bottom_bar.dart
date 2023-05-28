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

class NavigationNavBar extends StatelessWidget{
  int current_tab = 0;
  late var tabs = [
    HomeScreen(),
   SearchScreen(),
   BookingScreen(),
    ProfileScreen(),
  ];


  @override
Widget build(BuildContext context){
    var bloc = context.read<ProfileBloc>();
    bloc.add(getProfileScreenEvent());
    return Builder(builder: (context)=>
        BlocProvider(create: (context) => NavigationBloc(),
            child:  BlocBuilder<NavigationBloc, NavigationInfoState>(
                builder: (context, state){
                  return
                    Scaffold(
                      extendBody: true,
                      body:IndexedStack(
                      index: state.selectedIndex,
                      children:tabs
                  ),
                      bottomNavigationBar: Salomon_nav_bar(),
                    );
                }
            )
        ));
  }
  Widget findSelectedIndex(NavigationInfoState state) {
    if ( state.selectedIndex == 0 ) {
      return HomeScreen();
    } else if(state.selectedIndex == 1 ) {
      return SearchScreen();
    } else if (state.selectedIndex == 2) {
      return BookingScreen();
    }
    else if (state.selectedIndex == 3) {
      return ProfileScreen();
    }
    else {
      return HomeScreen();
    }
  }
}

class Salomon_nav_bar extends StatelessWidget{
@override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationInfoState>(
        builder: (context, state){
          return AnimatedContainer  (
            duration: const Duration(milliseconds: 1000),
            height: 58 + 25,
            child: Wrap(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(2,4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: SalomonBottomBar(
                      currentIndex: state.selectedIndex,
                      onTap: (index) {
                        BlocProvider.of<NavigationBloc>(context).add(NavigateEvent(selectedIndex: index));
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
        }
    );
  }
}
