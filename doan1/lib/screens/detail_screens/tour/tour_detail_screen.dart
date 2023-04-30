import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/tour_model.dart';

class TourDetailScreen extends StatefulWidget {
  final Tour tour;
  final Image tourImg;
  final int type;

  const TourDetailScreen({
    Key? key,
    required this.tour,
    required this.tourImg,
    required this.type,
  }) : super(key: key);

  @override
  _TourDetailScreenState createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build for TourDetailScreen
    return Scaffold(
      body: Container(),
    );
  }
}