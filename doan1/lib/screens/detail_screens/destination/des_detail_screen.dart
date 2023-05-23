import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../models/destination_model.dart';

class DestinationDetailScreen extends StatelessWidget {
  final Destination destination;
  final Image img;
  final int type;

  const DestinationDetailScreen({
    Key? key,
    required this.destination,
    required this.img,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController listController = PageController();
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Hero(
              tag: type == 1 ? destination.name : destination.description,
              child: PageView.builder(
                controller: listController,
                itemCount: destination.images.length,
                itemBuilder:(context, index) {
                  return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(destination.images[index]),
                              fit: BoxFit.cover
                          )
                      )// image:AssetImage(url),),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 30.0,
            ),
            child: Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                },
                  icon: const Icon(Icons.arrow_back_ios_new),
                  color: Colors.white,),
                const Spacer(),
                const Icon(
                  FontAwesomeIcons.ellipsisV,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
          Positioned(
            left: 20.0,
            right: 20,
            bottom: 40,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destination.name,
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Colors.white,
                            size: 24,
                          ),
                          Text(
                            destination.province,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        destination.description,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                SmoothPageIndicator(
                  controller: listController,
                  count: destination.images.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.orange,
                    dotColor: Color(0xFFababab),
                    dotHeight: 6,
                    dotWidth: 6,
                    spacing: 4.8,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
