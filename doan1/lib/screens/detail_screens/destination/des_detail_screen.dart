import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../BLOC/widget_item/article_item/article_item_bloc.dart';

class DestinationDetailScreen extends StatelessWidget {
  final int type;

  const DestinationDetailScreen({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController listController = PageController();
    var articleItemBloc = context.read<ArticleItemBloc>();
    return BlocBuilder<ArticleItemBloc,ArticleItemState>(
      builder: (context, state) => articleItemBloc.article == null ?
      const Center(
              child: CircularProgressIndicator(),
            ) :
      SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Hero(
                  tag: type == 1 ? articleItemBloc.article!.id.toString() : '${articleItemBloc.article!.id}1',
                  child: articleItemBloc.listImages == null ? const Center(
                    child: CircularProgressIndicator(),
                  ) : PageView.builder(
                    controller: listController,
                    itemCount: articleItemBloc.listImages!.length,
                    itemBuilder:(context, index) {
                      return FadeInImage(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                        image:
                        NetworkImage(articleItemBloc.listImages !=null ? articleItemBloc.listImages![index]:""),
                        placeholder: const AssetImage('assets/images/loading.gif'),
                        fit: BoxFit.cover,
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
                            articleItemBloc.article != null ? articleItemBloc.article!.title! : "Loading...",
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
                                articleItemBloc.article != null ? "${articleItemBloc.article!.province!}, ${articleItemBloc.article!.city!}" : "Loading...",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            articleItemBloc.article != null ? articleItemBloc.article!.description! : "Loading...",
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
                    articleItemBloc.listImages == null ? const Center(
                      child: CircularProgressIndicator(),
                    )
                        :
                    SmoothPageIndicator(
                      controller: listController,
                      count: articleItemBloc.listImages!.length,
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
        ),
      ),
    );
  }
}
