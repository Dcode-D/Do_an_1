import 'package:doan1/screens/booking/booking_screen.dart';
import 'package:doan1/screens/home/home_screen.dart';
import 'package:doan1/screens/profile/profile_screen.dart';
import 'package:doan1/screens/search/search_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App>{
  int current_tab = 0;
  bool hide_navbar = false;
  late var tabs;

  void changeBottomNavbarVisibility(bool value) {
    if (hide_navbar != value) {
      setState(() {
        hide_navbar = value;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    tabs = [
      HomeScreen(callbackSetNavbar: changeBottomNavbarVisibility),
      SearchScreen(callbackSetNavbar: changeBottomNavbarVisibility),
      BookingScreen(callbackSetNavbar: changeBottomNavbarVisibility),
      ProfileScreen(callbackSetNavbar: changeBottomNavbarVisibility),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body:IndexedStack(
          index: current_tab,
          children:tabs
        ),
        bottomNavigationBar: AnimatedContainer  (
          duration: const Duration(milliseconds: 200),
          height: hide_navbar ? 0 : kBottomNavigationBarHeight + 25,
          child: Wrap(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(2,4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: SalomonBottomBar(
                    currentIndex: current_tab,
                    onTap: (int index) {
                      setState(() {
                        current_tab = index;
                      });
                    },
                    backgroundColor: Colors.white,
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
        )
    );
  }
}