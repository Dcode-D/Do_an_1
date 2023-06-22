import 'dart:math';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:doan1/BLOC/screen/all_screen/article/article_bloc.dart';
import 'package:doan1/BLOC/widget_item/article_item/article_item_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/detail_screens/destination/des_detail_screen.dart';

const cardAspectRatio = 12.0 / 16.0;
const widgetAspectRatio = cardAspectRatio * 1.2 ;

class CardScrollWidget extends StatelessWidget {
  final double currentPage;
  var padding = 15.0;
  var verticalInset = 20;
  var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;

  CardScrollWidget({super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    var articleBloc = context.read<ArticleBloc>();

    return BlocBuilder<ArticleBloc,ArticleState>(
      builder:(context,state) =>
          AspectRatio(
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

          for (var i = 0; i < articleBloc.listArticle!.length; i++) {
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
                          BlocProvider<ArticleItemBloc>(
                            create: (context) => ArticleItemBloc()..add(GetArticleItemData(article: articleBloc.listArticle![i])),
                            child: const DestinationDetailScreen(
                              type: 2,
                            ),
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
                            tag: '${articleBloc.listArticle![i].id.toString()}1',
                            child:FadeInImage(
                              imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                              image:
                              NetworkImage(articleBloc.listArticle != null ? '$baseUrl/files/${articleBloc.listArticle![i].images![0]['_id']}': ""),
                              placeholder: const AssetImage('assets/images/loading.gif'),
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
                                    articleBloc.listArticle![i].title != null ? articleBloc.listArticle![i].title! : "loading...",
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
                                        articleBloc.listArticle![i].province != null && articleBloc.listArticle![i].city != null ?
                                        "${articleBloc.listArticle![i].province!}, ${articleBloc.listArticle![i].city!}" : "loading...",
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
                                      children: [
                                        Text(
                                          "Detail",
                                          style: GoogleFonts.raleway(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          )
                                        ),
                                        const SizedBox(width: 5.0),
                                        const Icon(
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
      ),
    );
  }
}