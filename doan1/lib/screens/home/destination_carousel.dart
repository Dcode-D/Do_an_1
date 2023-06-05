import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BLOC/screen/all_screen/all_article/article_bloc.dart';
import '../../models/destination_model.dart';
import '../../widgets/card_scroll_widget.dart';
import '../detail_screens/destination/des_detail_screen.dart';

const cardAspectRatio = 12.0 / 16.0;
const widgetAspectRatio = cardAspectRatio * 1.2;

class DestinationCarousel extends StatefulWidget {

  @override
  _DestinationCarouselState createState() => _DestinationCarouselState();
}

class _DestinationCarouselState extends State<DestinationCarousel> {
  var currentPage = 4.0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var articleBloc = context.read<ArticleBloc>();

    PageController controller;
    if(articleBloc.listArticle != null){
      controller = PageController(initialPage: articleBloc.listArticle!.length);
    }
    else{
      controller = PageController(initialPage: 0);
    }
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
      });
    });
    return BlocBuilder<ArticleBloc,ArticleState>(
      builder:(context,state) =>
          articleBloc.listArticle == null ? const Center(child: CircularProgressIndicator()) :
          Column(
          children: [
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Top Destinations',
                  style: GoogleFonts.raleway(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
                GestureDetector(
                  onTap: () => print('See All'),
                  child: Text(
                    'See All',
                    style: GoogleFonts.raleway(
                        fontSize: 20,
                        color: Colors.orange,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w600
                    )
                  ),
                ),
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.antiAlias,
            children: <Widget>[
              BlocProvider.value(
                value: articleBloc,
                child: CardScrollWidget(
                  currentPage: currentPage,
                ),
              ),
              Positioned(
                left: 150,
                bottom: 0,
                right: 0,
                top: 0,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: articleBloc.listArticle!.length,
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
      ),
    );
  }
}
