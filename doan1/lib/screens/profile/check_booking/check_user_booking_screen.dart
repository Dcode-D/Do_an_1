import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/user.dart';

class CheckUserBookingScreen extends StatelessWidget{
  User? user;
  CheckUserBookingScreen({this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Information',
            style: GoogleFonts.raleway(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Personal data',
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
                        'Full name',
                        style: GoogleFonts.raleway(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                          children:[
                            const Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                              size: 20,
                            ),
                            const SizedBox(width: 20),
                            user == null ? const Text('Loading...') :
                            Text(
                              '${user!.firstname} ${user!.lastname}',
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            )
                          ]
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Address',
                        style: GoogleFonts.raleway(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                          children:[
                            const Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              color: Colors.black,
                              size: 20,
                            ),
                            const SizedBox(width: 20),
                            user == null ? const Text('Loading...') :
                            Flexible(
                              child: Text(
                                user!.address,
                                style: GoogleFonts.raleway(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ]
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Date of birth',
                        style: GoogleFonts.raleway(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                          children:[
                            const Icon(
                              FontAwesomeIcons.birthdayCake,
                              color: Colors.black,
                              size: 20,
                            ),
                            const SizedBox(width: 20),
                            Text(
                              '15/10/2002',
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            )
                          ]
                      ),
                      const SizedBox(height: 10),
                    ]
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Contact',
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
                        'Email',
                        style: GoogleFonts.raleway(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                          children:[
                            const Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                              size: 20,
                            ),
                            const SizedBox(width: 20),
                            user == null ? const Text('Loading...') :
                            Text(
                              user!.email,
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            )
                          ]
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Phone number',
                        style: GoogleFonts.raleway(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                          children:[
                            const Icon(
                              FontAwesomeIcons.phone,
                              color: Colors.black,
                              size: 20,
                            ),
                            const SizedBox(width: 20),
                            user == null ? const Text('Loading...') :
                            Text(
                              user!.phonenumber,
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            )
                          ]
                      ),
                      const SizedBox(height: 10),
                    ]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}