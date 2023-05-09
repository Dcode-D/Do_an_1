import 'package:doan1/BLOC/authentication/authentication_page.dart';
import 'package:doan1/screens/login/login_screens.dart';
import 'package:doan1/widgets/dialog/log_out_dialog.dart';
import 'package:doan1/widgets/salomon_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
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
    return Scaffold(
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
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => EditProfileScreen()),);
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
                            ),
                          ],
                        )],
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
                        children: [
                          Text(
                          "Full name",
                          style: const TextStyle(
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
                          Text(
                            "Address",
                            style: const TextStyle(
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
                          Text(
                            "ID Card",
                            style: const TextStyle(
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
                                  FontAwesomeIcons.idCard,
                                  color: Colors.black,
                                  size: 20,
                                ), const SizedBox(width: 20),
                                Text(
                                  "0792********",
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
                          Text(
                            "Email",
                            style: const TextStyle(
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
                          Text(
                            "Phone Number",
                            style: const TextStyle(
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
                          Text(
                            "Bank Account",
                            style: const TextStyle(
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
                                  FontAwesomeIcons.bank,
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
                    Container(
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
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const LogOutDialog();
                              },
                            );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
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
                    SizedBox(height: 80),
                  ]),
              ),
              ]),
          ),
        ])
    );
  }
}