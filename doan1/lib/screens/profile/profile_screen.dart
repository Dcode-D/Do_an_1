import 'package:doan1/BLOC/authentication/authentication_bloc.dart';
import 'package:doan1/BLOC/profile/edit_profile/edit_profile_bloc.dart';
import 'package:doan1/BLOC/profile/profile_view/profile_bloc.dart';
import 'package:doan1/screens/profile/create_post_screen.dart';
import 'package:doan1/screens/profile/create_service_screen.dart';
import 'package:doan1/screens/profile/favorite_screen.dart';
import 'package:doan1/widgets/dialog/log_out_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/model/user.dart';
import 'check_booking/check_booking_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  User? user;
  String? imagePath;

  ProfileScreen({super.key, this.user,this.imagePath});

  @override
  Widget build(BuildContext context) {
    Logout()=>{
    context.read<AuthenticationBloc>().add(LogoutEvent())
    };

    return BlocBuilder<ProfileBloc,ProfileState>(
      builder: (context,state) =>
      user != null ?
      Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 10),
          child: SpeedDial(
            animatedIcon: AnimatedIcons.add_event,
            animatedIconTheme: const IconThemeData(size: 22.0),
            backgroundColor: Colors.orange,
            visible: true,
            curve: Curves.bounceIn,
            children: [
              SpeedDialChild(
                child: const Icon(Icons.post_add),
                backgroundColor: Colors.orange,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreatePostScreen())),
                label: 'Create Post',
                labelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
                labelBackgroundColor: Colors.orange,
              ),
              SpeedDialChild(
                child: const Icon(Icons.sell_rounded),
                backgroundColor: Colors.orange,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateServiceScreen())),
                label: 'Create Service',
                labelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
                labelBackgroundColor: Colors.orange,
              ),
              SpeedDialChild(
                child: const Icon(FontAwesomeIcons.checkCircle),
                backgroundColor: Colors.orange,
                onTap: ()
                => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckBookingScreen())),
                label: 'Check booking',
                labelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
                labelBackgroundColor: Colors.orange,
              ),
            ],),
        ),
        body: Stack(
          children:[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children:[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                      image: DecorationImage(
                        image: NetworkImage(imagePath!),
                        fit: BoxFit.cover,
                      ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Theme.of(context).primaryColor,
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${user!.firstname} ${user!.lastname}",
                              style: GoogleFonts.raleway(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.envelope,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                    user!.email,
                                    style: GoogleFonts.raleway(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Personal Information",
                            style: GoogleFonts.raleway(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Row(
                            children:[
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavoriteScreen()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                  child: const Icon(
                                    FontAwesomeIcons.heart,
                                    color: Colors.orange,
                                    size: 28,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          BlocProvider(
                                            create: (_) => EditProfileBloc(context),
                                            child: EditProfileScreen(user: user!),
                                          )
                                      ));
                                },
                                child: Container(
                                  width: 50,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                  child: const Image(
                                    image: AssetImage('assets/icons/icon-edit.png'),
                                    color: Colors.orange,
                                  ),
                                ),
                              )
                            ]),
                        ],),
                      const SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.3),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                            "Full name",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                            const SizedBox(height: 15),
                            Row(
                              children:[
                              const Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                              size: 20,
                              ), const SizedBox(width: 20),
                                Text(
                                  "${user!.firstname} ${user!.lastname}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Raleway',
                                    color: Colors.black,),
                                ),
                              ]),
                            const SizedBox(height: 15),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: Colors.black.withOpacity(0.3),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Address",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                                children:[
                                  const Icon(
                                    FontAwesomeIcons.mapMarkerAlt,
                                    color: Colors.black,
                                    size: 20,
                                  ), const SizedBox(width: 20),
                                  Text(
                                    user!.address,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Raleway',
                                      color: Colors.black,),
                                  ),
                                ]),
                            const SizedBox(height: 15),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: Colors.black.withOpacity(0.3),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Date of birth",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                                children:[
                                  const Icon(
                                    FontAwesomeIcons.cakeCandles,
                                    color: Colors.black,
                                    size: 20,
                                  ), const SizedBox(width: 20),
                                  Text(
                                    "15/10/2002",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Raleway',
                                      color: Colors.black,),
                                  ),
                                ]),
                            const SizedBox(height: 15),
                      ])
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Contact",
                        style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.3),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            const Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),),
                            const SizedBox(height: 15),
                            Row(
                                children:[
                                  const Icon(
                                    FontAwesomeIcons.envelope,
                                    color: Colors.black,
                                    size: 20,
                                  ), const SizedBox(width: 20),
                                  Text(
                                    user!.email,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Raleway',
                                      color: Colors.black,),
                                  ),
                                ]),
                            const SizedBox(height: 15),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: Colors.black.withOpacity(0.3),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Phone Number",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                                children:[
                                  const Icon(
                                    FontAwesomeIcons.phone,
                                    color: Colors.black,
                                    size: 20,
                                  ), const SizedBox(width: 20),
                                  Text(
                                    user!.phonenumber,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Raleway',
                                      color: Colors.black,),
                                  ),
                                ]),
                            const SizedBox(height: 15),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: Colors.black.withOpacity(0.3),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Social Network",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                                children:[
                                  const Icon(
                                    FontAwesomeIcons.globe,
                                    color: Colors.black,
                                    size: 20,
                                  ), const SizedBox(width: 20),
                                  Text(
                                    "Not Linked",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Raleway',
                                      color: Colors.black,),
                                  ),
                                ]),
                            const SizedBox(height: 15),
                          ]
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return LogOutDialog(logout: Logout,);
                                },
                              );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.signOutAlt,
                                color: Colors.red,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "Sign Out",
                                style: GoogleFonts.raleway(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,)
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 80),
                    ]),
                ),
                ]),
            ),
          ])
      )
          :
      const Center(
        child: CircularProgressIndicator(
          color: Colors.orange,
        ),
      ),
    );
  }
}