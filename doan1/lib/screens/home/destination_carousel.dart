import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/destination_model.dart';
import '../../widgets/card_scroll_widget.dart';
import '../detail_screens/destination/des_detail_screen.dart';

const cardAspectRatio = 12.0 / 16.0;
const widgetAspectRatio = cardAspectRatio * 1.2;

class DestinationCarousel extends StatefulWidget {
  final List<Destination> destinationList;

  DestinationCarousel({Key? key, required this.destinationList})
      : super(key: key);

  @override
  _DestinationCarouselState createState() => _DestinationCarouselState();
}

class _DestinationCarouselState extends State<DestinationCarousel> {
  var currentPage = 4.0;
  List<Image> images = [];
//TODO: Make list of images from destinationList and use it in CardScrollWidget
  @override
  void initState() {
    super.initState();

    for (var destination in widget.destinationList) {
      final img = Image.asset(destination.img);
      images.add(img);
    }
  }

  @override
  Widget build(BuildContext context) {
    PageController controller =
    PageController(initialPage: widget.destinationList.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
      });
    });

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Top Destinations',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () => print('See All'),
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            CardScrollWidget(
              currentPage: currentPage,
              destinationList: widget.destinationList,
              images: images,
            ),
            Positioned(
              left: 150,
              bottom: 0,
              right: 0,
              top: 0,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: widget.destinationList.length,
                controller: controller,
                reverse: true,
                itemBuilder: (context, index) {
                  return Container();
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
