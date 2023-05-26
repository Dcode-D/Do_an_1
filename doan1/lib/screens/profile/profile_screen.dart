import 'package:doan1/BLOC/authentication/authentication_bloc.dart';
import 'package:doan1/BLOC/profile/edit_profile/edit_profile_bloc.dart';
import 'package:doan1/screens/profile/create_post_screen.dart';
import 'package:doan1/screens/profile/create_service_screen.dart';
import 'package:doan1/widgets/dialog/log_out_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    Function Logout =()=>{
    context.read<AuthenticationBloc>().add(LogoutEvent())
  };
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 65, horizontal: 10),
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
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/avatar-wallpaper.jpg'),
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
                            "Eng Dũng",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
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
                                "EngDungMup123@gmail.com",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: (){},
                        child: Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.3),
                          ),
                          child: const Image(
                            image: AssetImage('assets/icons/icon-camera.png'),
                            color: Colors.white,
                          ),
                        ),
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
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Row(
                          children:[
                            InkWell(
                              onTap: (){
                                //TODO: Add favorite page
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
                                          create: (_) => EditProfileBloc(),
                                          child: EditProfileScreen(),
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
                                "Nguyễn Huy Trí Dũng",
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
                                  "Thành phố Lâm Đồng",
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
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
                                  "EngDungMup123@gmail.com",
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
                                  "0857335125",
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
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.signOutAlt,
                              color: Colors.red,
                              size: 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Sign Out",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                              ),
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
    );
  }
}