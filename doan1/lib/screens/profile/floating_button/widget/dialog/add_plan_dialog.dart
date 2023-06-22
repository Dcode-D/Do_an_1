import 'package:dio/dio.dart';
import 'package:doan1/BLOC/screen/all_screen/article/article_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../BLOC/news_create/tour/create_tour_bloc.dart';

class AddPlanDialog extends StatefulWidget {
  @override
  _AddPlanDialogState createState() => _AddPlanDialogState();
}

class _AddPlanDialogState extends State<AddPlanDialog> {
  @override
  Widget build(BuildContext context) {
    var scrollController = ScrollController();
    var search = TextEditingController();
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        context.read<ArticleBloc>().add(GetArticleData());
      }
    });
    search.addListener(() {
      context.read<ArticleBloc>().add(GetArticleByQuery(search.text));
    });
    var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close)),
                Text(
                  "Plan",
                  style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                    )),
              ],
            ),
            //search
            TextField(
                controller: search,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintText: "Search...")),
            BlocBuilder<ArticleBloc, ArticleState>(
              builder: (context, state) {
                return state.getDataSuccess
                    ? Expanded(
                  child: ListView.builder(
                    addAutomaticKeepAlives: true,
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    itemCount:
                    context.read<ArticleBloc>().listArticle!.length,
                    itemBuilder: (context, index) {
                      return BlocBuilder<CreateTourBloc, CreateTourState>(
                        builder: (context, state) {
                          return CheckboxListTile(
                            title: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 100,
                                  height: 120,
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    child: FadeInImage(
                                      imageErrorBuilder:
                                          (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                                      image: NetworkImage(context
                                          .read<ArticleBloc>()
                                          .listArticle !=
                                          null
                                          ? '$baseUrl/files/${context.read<ArticleBloc>().listArticle![index].images![0]['_id']}'
                                          : ""),
                                      placeholder: const AssetImage(
                                          'assets/images/loading.gif'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          context.read<ArticleBloc>().listArticle![index].title == null ?
                                          'No title'
                                              :
                                          context.read<ArticleBloc>().listArticle![index].title!,
                                          style: GoogleFonts.raleway(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          context.read<ArticleBloc>().listArticle![index].province == null &&
                                              context.read<ArticleBloc>().listArticle![index].city == null
                                              ? 'No address'
                                              :
                                          '${context.read<ArticleBloc>().listArticle![index].province}, ${context.read<ArticleBloc>().listArticle![index].city}',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.raleway(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          context.read<ArticleBloc>().listArticle![index].description == null ?
                                          'No description'
                                              :
                                          context.read<ArticleBloc>().listArticle![index].description!,
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.raleway(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                            value: context.read<CreateTourBloc>().listSelectedTourPlan.map((e) => e.id).contains(context.read<ArticleBloc>().listArticle![index].id),
                            onChanged: (value) {
                              if (value!) {
                                context.read<CreateTourBloc>().add(
                                    SetTourPlan(tourPlan: [
                                      context.read<ArticleBloc>().listArticle![index]]));
                              } else {
                                context.read<CreateTourBloc>().add(
                                    RemoveTourPlan(article: context.read<ArticleBloc>().listArticle![index]));
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                )
                    : const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}

