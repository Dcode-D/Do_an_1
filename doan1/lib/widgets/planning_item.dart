import 'package:dio/dio.dart';
import 'package:doan1/BLOC/widget_item/article_item/article_item_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../BLOC/widget_item/tour_item/tour_item_bloc.dart';
import '../screens/detail_screens/destination/des_detail_screen.dart';

class PlanningItem extends StatelessWidget {
  final int index;
  final int type;
  var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;

  PlanningItem({
    Key? key,
    required this.index,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tourItemBloc = context.read<TourItemBloc>();
    return BlocBuilder<TourItemBloc,TourItemState>(
      builder:(context,state) => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider<ArticleItemBloc>(
                    create: (context) => ArticleItemBloc()..add(GetArticleItemData(article: tourItemBloc.listArticle![index])),
                  )
                ],
                child: const DestinationDetailScreen(
                  type: 1,
                ),
              ),
            ),
          );
        },
        child:
            tourItemBloc.tour == null ?
                const Center(child: CircularProgressIndicator()) :
        Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
              height: 170.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    tourItemBloc.tour != null && tourItemBloc.listArticle != null ?
                    tourItemBloc.listArticle!.isNotEmpty ?
                    Text(
                      tourItemBloc.listArticle![index].title!,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ) : const Text('Loading') :
                    const Text('Loading'),
                    const SizedBox(height: 5.0),
                    Text(
                      tourItemBloc.tour != null && tourItemBloc.listArticle != null ?
                      tourItemBloc.listArticle!.isNotEmpty ?
                      tourItemBloc.listArticle![index].description! :
                      'Loading' :
                      'Loading',
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 20.0,
              top: 15.0,
              bottom: 15.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Stack(
                  children: [
                    Hero(
                      tag: tourItemBloc.listArticle![index].id.toString(),
                      child:
                      tourItemBloc.listImage != null && tourItemBloc.tour != null?
                      tourItemBloc.listImage!.isNotEmpty ?
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: FadeInImage(
                          height: 200,
                          width: 110,
                          imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                          image:
                          NetworkImage('$baseUrl/files/${tourItemBloc.listArticle![index].images![0]['_id']}'),
                          placeholder: const AssetImage('assets/images/loading.gif'),
                          fit: BoxFit.cover,
                        ),
                      ) : const SizedBox() : const SizedBox(),
                    ),
                    type == 1
                        ? Positioned(
                      top: 0,
                      left: -40,
                      child: Text(
                        index.toString(),
                        style: GoogleFonts.playfairDisplay(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 160.0,
                          fontWeight: FontWeight.w600,
                          height: 1.0,
                        ),
                      ),
                    )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
