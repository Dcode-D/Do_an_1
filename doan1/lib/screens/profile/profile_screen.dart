import 'package:doan1/BLOC/authentication/authentication_bloc.dart';
import 'package:doan1/BLOC/profile/edit_profile/edit_profile_bloc.dart';
import 'package:doan1/BLOC/profile/favorite/favorite_bloc.dart';
import 'package:doan1/BLOC/profile/manage_news/manage_news_bloc.dart';
import 'package:doan1/BLOC/profile/profile_view/profile_bloc.dart';
import 'package:doan1/BLOC/screen/all_screen/article/article_bloc.dart';
import 'package:doan1/BLOC/screen/book_history/book_history_bloc.dart';
import 'package:doan1/screens/profile/floating_button/create_car_service_screen.dart';
import 'package:doan1/screens/profile/floating_button/create_post_screen.dart';
import 'package:doan1/screens/profile/floating_button/create_hotel_service_screen.dart';
import 'package:doan1/screens/profile/floating_button/create_tour_screen.dart';
import 'package:doan1/screens/profile/favorite_screen.dart';
import 'package:doan1/screens/profile/floating_button/manage_service_screen.dart';
import 'package:doan1/screens/profile/manage_post_and_tour_screen.dart';
import 'package:doan1/widgets/dialog/log_out_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BLOC/news_create/tour/create_tour_bloc.dart';
import '../../BLOC/profile/booker/booker_bloc.dart';
import '../../BLOC/profile/manage_hotel_car/manage_service_bloc.dart';
import 'check_booking/check_booking_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Logout()=>{
      context.read<AuthenticationBloc>().add(LogoutEvent())
    };

    ProfileBloc profileBloc = context.read<ProfileBloc>();
    ArticleBloc articleBloc = context.read<ArticleBloc>();
    BookHistoryBloc bookHistoryBloc = context.read<BookHistoryBloc>();

    return BlocBuilder<ProfileBloc,ProfileState>(
      builder: (context,state) =>
      SafeArea(
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
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
                  onTap: () => Navigator.push(context,MaterialPageRoute(builder: (_) =>
                      BlocProvider<ProfileBloc>.value(
                          value: BlocProvider.of<ProfileBloc>(context),
                          child: CreatePostScreen()
                      )
                  )
                  ),
                  label: 'Create post',
                  labelStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                  labelBackgroundColor: Colors.orange,
                ),
                SpeedDialChild(
                  child: const Icon(FontAwesomeIcons.flag),
                  backgroundColor: Colors.orange,
                  onTap: ()
                  => Navigator.of(context).push(MaterialPageRoute(builder: (_) =>
                      MultiBlocProvider(
                        providers: [
                          BlocProvider<ProfileBloc>.value(
                              value: BlocProvider.of<ProfileBloc>(context)),
                          BlocProvider<ArticleBloc>.value(
                              value: articleBloc),
                        ],
                          child: BlocProvider<CreateTourBloc>(
                            create: (context) => CreateTourBloc(),
                              child: CreateTourScreen()))
                  )
                  ),
                  label: 'Create tour',
                  labelStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                  labelBackgroundColor: Colors.orange,
                ),
                SpeedDialChild(
                  child: const Icon(FontAwesomeIcons.hotel),
                  backgroundColor: Colors.orange,
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) =>
                  MultiBlocProvider(
                    providers: [
                      BlocProvider<ProfileBloc>.value(
                          value: BlocProvider.of<ProfileBloc>(context)),
                    ],
                      child: CreateHotelServiceScreen()))),
                  label: 'Create hotel service',
                  labelStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                  labelBackgroundColor: Colors.orange,
                ),
                SpeedDialChild(
                  child: const Icon(FontAwesomeIcons.car),
                  backgroundColor: Colors.orange,
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CreateCarServiceScreen())),
                  label: 'Create car service',
                  labelStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                  labelBackgroundColor: Colors.orange,
                ),
                SpeedDialChild(
                  child: const Icon(FontAwesomeIcons.checkCircle),
                  backgroundColor: Colors.orange,
                  onTap: ()
                  => Navigator.of(context).push(MaterialPageRoute(builder: (_) =>
                      MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: profileBloc),
                          BlocProvider.value(value: bookHistoryBloc),
                          BlocProvider<BookerBloc>(
                              create: (_) => BookerBloc()..add(GetBookerEvent(ownerId: profileBloc.user!.id,page: 1))
                          )
                        ],
                          child: CheckBookingScreen()))),
                  label: 'Check booking',
                  labelStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                  labelBackgroundColor: Colors.orange,
                ),
                SpeedDialChild(
                  child: const Icon(FontAwesomeIcons.businessTime),
                  backgroundColor: Colors.orange,
                  onTap: ()
                  => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                      MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: profileBloc),
                          BlocProvider<ManageServiceBloc>(
                            create:(_) => ManageServiceBloc()..add(GetDataByOwner(profileBloc.user!.id,1)),
                          ),
                        ],
                          child: ManageServiceScreen()))),
                  label: 'Manage service',
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
                    profileBloc.image != null ?
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.8,
                    child: Stack(
                      children:
                      [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          child: FadeInImage(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2.5,
                            imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                            image:
                            NetworkImage(profileBloc.image!=null ? profileBloc.image as String:""),
                            placeholder: const AssetImage('assets/images/loading.gif'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
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
                                  profileBloc.user!=null?"${profileBloc.user!.firstname} ${profileBloc.user!.lastname}":"loading...",
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
                                        profileBloc.user!=null?profileBloc.user!.email:"loading...",
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
                      ]
                    ),

                  ) :
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.8,
                      child: Stack(
                          children:
                          [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                              child: Image.asset(
                                'assets/images/undefine-wallpaper.jpg',
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 2.5,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
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
                                        profileBloc.user!=null?"${profileBloc.user!.firstname} ${profileBloc.user!.lastname}":"loading...",
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
                                              profileBloc.user!=null?profileBloc.user!.email:"loading...",
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
                          ]
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
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                    MultiBlocProvider(
                                      providers: [
                                        BlocProvider<ProfileBloc>.value(value: profileBloc),
                                        BlocProvider<ManageNewsBloc>(
                                          create:(_) => ManageNewsBloc()..add(GetNews(userID: profileBloc.user!.id)),
                                        ),
                                      ],
                                        child: ManagePostAndTourScreen())));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                    child: const Icon(
                                      FontAwesomeIcons.solidNewspaper,
                                      color: Colors.orange,
                                      size: 28,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                        MultiBlocProvider(
                                          providers: [
                                            BlocProvider.value(value: profileBloc),
                                            BlocProvider.value(value: bookHistoryBloc),
                                            BlocProvider(create:(_) => FavoriteBloc())
                                          ],
                                            child: FavoriteScreen())));
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
                                const SizedBox(width: 15),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) =>
                                        BlocProvider.value(
                                            value: profileBloc,
                                          child:
                                            BlocProvider(
                                              create: (_) => EditProfileBloc(context),
                                              child: EditProfileScreen(),
                                            )
                                        ))
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                    child: const Icon(
                                      FontAwesomeIcons.edit,
                                      color: Colors.orange,
                                      size: 30,
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
                              Text(
                              "Full name",
                              style: GoogleFonts.raleway(
                                fontSize: 18,
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
                                    profileBloc.user!=null?"${profileBloc.user!.firstname} ${profileBloc.user!.lastname}":"loading...",
                                    style:GoogleFonts.raleway(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
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
                                style: GoogleFonts.raleway(
                                  fontSize: 18,
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
                                      profileBloc.user!=null?profileBloc.user!.address:"loading...",
                                      style:GoogleFonts.raleway(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
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
                              const Row(
                                  children:[
                                    Icon(
                                      FontAwesomeIcons.cakeCandles,
                                      color: Colors.black,
                                      size: 20,
                                    ), SizedBox(width: 20),
                                    Text(
                                      "15/10/2002",
                                      style: TextStyle(
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
                              Text(
                                "Email",
                                style: GoogleFonts.raleway(
                                  fontSize: 18,
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
                                      profileBloc.user!=null?profileBloc.user!.email:"loading...",
                                      style:GoogleFonts.raleway(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
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
                                style: GoogleFonts.raleway(
                                  fontSize: 18,
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
                                      profileBloc.user!=null?profileBloc.user!.phonenumber:"loading...",
                                      style: GoogleFonts.raleway(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
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
                                "Social Network",
                                style: GoogleFonts.raleway(
                                  fontSize: 18,
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
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      "Not Linked",
                                      style: GoogleFonts.raleway(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      )
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
        ),
      )

    );
  }
}