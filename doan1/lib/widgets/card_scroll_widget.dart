import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/destination_model.dart';
import '../screens/detail_screens/destination/des_detail_screen.dart';

const cardAspectRatio = 12.0 / 16.0;
const widgetAspectRatio = cardAspectRatio * 1.2 ;

class CardScrollWidget extends StatelessWidget {

  var currentPage;
  List<Destination> destinationList;
  List<Image> images;
  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidget({
    required this.currentPage,
    required this.destinationList,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = [];

        for (var i = 0; i < destinationList.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DestinationDetailScreen(
                          destination: destinationList[i],
                          img: images[i],
                          type: 1,
                        ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(3.0, 6.0),
                          blurRadius: 10.0)
                    ],
                  ),
                  child: AspectRatio(
                    aspectRatio: cardAspectRatio,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Hero(
                          tag: destinationList[i].name,
                          child: Image(
                            image: images[i].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              bottom: 12.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  destinationList[i].name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28.0,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_pin,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    Text(
                                      destinationList[i].province,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                Container(
                                  width: 120,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0,
                                    vertical: 8.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "Detail",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(width: 5.0),
                                      Icon(
                                        FontAwesomeIcons.longArrowAltRight,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}