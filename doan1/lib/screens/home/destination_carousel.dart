
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BLOC/screen/all_screen/article/article_bloc.dart';
import '../../widgets/card_scroll_widget.dart';

const cardAspectRatio = 12.0 / 16.0;
const widgetAspectRatio = cardAspectRatio * 1.2;

class DestinationCarousel extends StatefulWidget {

  @override
  _DestinationCarouselState createState() => _DestinationCarouselState();
}

class _DestinationCarouselState extends State<DestinationCarousel> {
  var currentPage = 3.0;
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
      controller = PageController(initialPage: 3);
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
