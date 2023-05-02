import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/hotel_model.dart';

class HotelDetailScreen extends StatefulWidget{
  final Hotel hotel;
  final Image hotelImg;
  final int type;

  const HotelDetailScreen({
    Key? key,
    required this.hotel,
    required this.hotelImg,
    required this.type
  }) : super(key: key);

  @override
  _HotelDetailScreenState createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
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
                          color: Colors.white,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Hero(
                      tag: widget.type == 1 ? widget.hotel.id : widget.hotel.name,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: CarouselSlider(
                          items: widget.hotel.imageUrls.map((url) {
                            return Container(
                             margin: const EdgeInsets.all(5.0),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10.0),
                               image: DecorationImage(
                                 image: AssetImage(url),
                                 fit: BoxFit.cover
                               )
                               // image:AssetImage(url),
                             ),
                              );
                          }).toList(),
                          options: CarouselOptions(
                              initialPage: 0,
                              autoPlay: false,
                              enlargeCenterPage: true,
                              aspectRatio: 1/1,
                        )
                      ),
                    ),
                    ),
                  ),
                  // buttons row
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
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
                        // Row(
                        //   children: <Widget>[
                        //     IconButton(
                        //       icon: const Icon(Icons.search),
                        //       iconSize: 30.0,
                        //       color: Colors.black,
                        //       onPressed: () => Navigator.pop(context),
                        //     ),
                        //     IconButton(
                        //       icon: const Icon(FontAwesomeIcons.sortAmountDown),
                        //       iconSize: 25.0,
                        //       color: Colors.black,
                        //       onPressed: () => Navigator.pop(context),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  // name and province
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}