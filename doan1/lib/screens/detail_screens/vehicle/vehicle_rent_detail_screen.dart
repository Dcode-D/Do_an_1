import 'package:doan1/models/vehicle_model.dart';
import 'package:doan1/screens/detail_screens/vehicle/vehicle_book_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class VehicleRentDetailScreen extends StatefulWidget{
  final Vehicle vehicle;
  final Image vehicleImg;
  final int type;

  const VehicleRentDetailScreen({
    Key? key,
    required this.vehicle,
    required this.vehicleImg,
    required this.type,
  }) : super(key: key);

  @override
  _VehicleRentDetailScreenState createState() => _VehicleRentDetailScreenState();
}

class _VehicleRentDetailScreenState extends State<VehicleRentDetailScreen>{
  final PageController listController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Hero(
            tag: widget.vehicle.id,
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
                    itemCount: widget.vehicle.imageUrls.length,
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
                                  image: AssetImage(widget.vehicle.imageUrls[index]),
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
              count: widget.vehicle.imageUrls.length,
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.orange,
                dotColor: Color(0xFFababab),
                dotHeight: 4.8,
                dotWidth: 6,
                spacing: 4.8,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 280,
                      child: Text(
                        widget.vehicle.name,
                        style: GoogleFonts.raleway(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text("${widget.vehicle.price}\$/Day",
                      style: GoogleFonts.raleway(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,),),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.info, size: 18.0, color: Colors.grey),
                    const SizedBox(width: 10.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width-48,
                      child: Text(
                        widget.vehicle.description,
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
                    const Icon(FontAwesomeIcons.car, size: 18.0, color: Colors.grey),
                    const SizedBox(width: 10.0),
                    Text(
                      widget.vehicle.owner,
                      style: GoogleFonts.raleway(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.mapMarkerAlt, size: 18.0, color: Colors.grey),
                    const SizedBox(width: 10.0),
                    Text(
                      widget.vehicle.address,
                      style: GoogleFonts.raleway(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),],
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
                  VehicleRentBookInfoScreen()));
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
                  VehicleRentBookInfoScreen()));
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
    );
  }

}