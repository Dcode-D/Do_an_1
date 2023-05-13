import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../models/tour_model.dart';
import '../../detail_screens/tour/tour_detail_screen.dart';

class TourItemForAll extends StatelessWidget{
  final Tour tour;
  final Image tourImg;

  TourItemForAll({
    Key? key,
    required this.tour,
    required this.tourImg,
  }) : super(key: key);

  final formatCurrency = NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => TourDetailScreen(
              tour: tour,
              tourImg: tourImg,
              type: 1,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image(
                  height: 150,
                  width: MediaQuery.of(context).size.width-56,
                  image: tourImg.image,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  top: 10.0,
                  left: 10.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 5.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.orange,
                    ),
                    child: const Text(
                    'Tour',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Raleway',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                right: 10.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      tour.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),),
              Positioned(
                left: 10.0,
                bottom: 10.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Icon(
                          FontAwesomeIcons.dollarSign,
                          size: 16.0,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 2.0),
                        Text(
                          '${formatCurrency.format(int.parse(tour.price))} VND',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 15.0,
                bottom: 10.0,
                  child: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        size: 16.0,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 2.0),
                      Text(
                        '${tour.destinationIDList.length} locations',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
              ),
            ],
          )
        ),
      ),
    );
  }

}