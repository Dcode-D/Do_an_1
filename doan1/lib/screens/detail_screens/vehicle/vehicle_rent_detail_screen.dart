import 'package:doan1/BLOC/vehicle_booking/vehicle_booking_bloc.dart';
import 'package:doan1/BLOC/widget_item/car_item/car_item_bloc.dart';
import 'package:doan1/screens/detail_screens/vehicle/vehicle_book_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../BLOC/profile/profile_view/profile_bloc.dart';


class VehicleRentDetailScreen extends StatefulWidget{
  final int type;


  const VehicleRentDetailScreen({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  _VehicleRentDetailScreenState createState() => _VehicleRentDetailScreenState();
}

class _VehicleRentDetailScreenState extends State<VehicleRentDetailScreen>{
  final PageController listController = PageController();
  final formatCurrency = NumberFormat("#,###");
  @override
  Widget build(BuildContext context) {
    var carItemBloc = context.read<CarItemBloc>();
    var profileBloc = context.read<ProfileBloc>();
    return BlocBuilder<CarItemBloc,CarItemState>(
      builder: (context,state) =>
      carItemBloc.vehicle != null ?
      Scaffold(
        body: Column(
          children: <Widget>[
            Hero(
              tag: carItemBloc.vehicle!.id.toString(),
              child: Stack(
                children:<Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 8.0),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: PageView.builder(
                      controller: listController,
                      itemCount: carItemBloc.vehicle!.images!.length,
                      itemBuilder:(context, index) {
                        return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 10.0,
                                  ),
                                ],
                                image: DecorationImage(
                                    image: NetworkImage(carItemBloc.listImage![index]),
                                    fit: BoxFit.cover
                                )
                            )// image:AssetImage(url),),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 40.0),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black.withOpacity(0.3)
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        color: Colors.white,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ]
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: SmoothPageIndicator(
                controller: listController,
                count: carItemBloc.vehicle!.images!.length,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Colors.orange,
                  dotColor: Color(0xFFababab),
                  dotHeight: 4.8,
                  dotWidth: 6,
                  spacing: 4.8,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 5,
                        child: Row(
                          children:[
                            const Icon(Icons.directions_car, size: 25.0, color: Colors.grey),
                            const SizedBox(width: 10.0),
                            Text(
                              carItemBloc.vehicle!.brand!,
                              style: GoogleFonts.raleway(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ]
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Text("${carItemBloc.vehicle!.pricePerDay!.toString()}\$/Day",
                          style: GoogleFonts.raleway(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,),),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.airline_seat_legroom_extra_sharp, size: 25.0, color: Colors.grey),
                      const SizedBox(width: 10.0),
                      Text(
                        '${carItemBloc.vehicle!.seats!} Seats',
                        style: GoogleFonts.raleway(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        carItemBloc.vehicle!.color!,
                        style: GoogleFonts.raleway(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      const Icon(FontAwesomeIcons.paintBrush, size: 25.0, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 25.0, color: Colors.grey),
                      const SizedBox(width: 10.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.8,
                        child: Text(
                          carItemBloc.vehicle!.address!,
                          style: GoogleFonts.raleway(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(FontAwesomeIcons.info, size: 25.0, color: Colors.grey),
                      const SizedBox(width: 10.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.8,
                        child: Text(
                          carItemBloc.vehicle!.description!,
                          style: GoogleFonts.raleway(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar:
        Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: carItemBloc),
                        BlocProvider.value(value: profileBloc),
                        BlocProvider<VehicleBookingBloc>(
                            create: (context) => VehicleBookingBloc())
                      ],
                        child: VehicleRentBookInfoScreen())));
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 2),
                width: MediaQuery.of(context).size.width*0.6,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Theme.of(context).primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Book now",
                      style: GoogleFonts.roboto(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    const Icon(
                      FontAwesomeIcons.angleDoubleRight,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    MultiBlocProvider(
                        providers: [
                          BlocProvider<CarItemBloc>.value(value: carItemBloc),
                          BlocProvider<ProfileBloc>.value(value: profileBloc),
                        ],
                        child: VehicleRentBookInfoScreen())));
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 2),
                width: MediaQuery.of(context).size.width*0.32,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Theme.of(context).primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Favorite",
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    const Icon(
                      FontAwesomeIcons.solidHeart,
                      color: Colors.white,
                    ),
                  ],),
              ),
            ),
          ],
        ),
      ):
      const Center(child: CircularProgressIndicator())
    );
  }

}