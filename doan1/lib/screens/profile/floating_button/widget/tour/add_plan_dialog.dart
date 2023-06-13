import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../BLOC/news_create/create_tour/create_tour_bloc.dart';
import '../../../../../data/model/article.dart';

class AddPlanDialog extends StatefulWidget{
  List<Article>? listArticle;
  List<Article> listSelectedArticle = [];

  AddPlanDialog({required this.listArticle});

  @override
  _AddPlanDialogState createState() => _AddPlanDialogState();
}

class _AddPlanDialogState extends State<AddPlanDialog>{
  @override
  Widget build(BuildContext context) {
    var createTourBloc = context.read<CreateTourBloc>();
    var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed:() => Navigator.pop(context),
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
                    onPressed:() {
                      createTourBloc.add(SetTourPlan(tourPlan: widget.listSelectedArticle));
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.check,color: Colors.green,)),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.listArticle!.length,
                itemBuilder: (context,index){
                  return CheckboxListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget> [
                        SizedBox(
                          width: 100,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage(
                              imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                              image:
                              NetworkImage(widget.listArticle != null ? '$baseUrl/files/${widget.listArticle![index].images![0]['_id']}': ""),
                              placeholder: const AssetImage('assets/images/loading.gif'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Flexible(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.listArticle![index].title == null ? 'No title' :
                                  widget.listArticle![index].title!,
                                  style: GoogleFonts.raleway(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  widget.listArticle![index].province == null && widget.listArticle![index].city == null ?
                                  'No address' :
                                  '${widget.listArticle![index].province}, ${widget.listArticle![index].city}',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.raleway(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Text(
                                  widget.listArticle![index].description == null ? 'No description' :
                                  widget.listArticle![index].description!,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.raleway(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                    value: widget.listSelectedArticle.contains(widget.listArticle![index]),
                    onChanged: (value){
                      setState(() {
                        if(value!){
                          widget.listSelectedArticle.add(widget.listArticle![index]);
                        }else{
                          widget.listSelectedArticle.remove(widget.listArticle![index]);
                        }
                      });
                    },

                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}