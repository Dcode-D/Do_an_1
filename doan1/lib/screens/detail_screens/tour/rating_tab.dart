
import 'package:doan1/BLOC/widget_item/rating/rating_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../BLOC/profile/profile_view/profile_bloc.dart';
import '../../../BLOC/widget_item/rating_item/rating_item_bloc.dart';
import '../../../BLOC/widget_item/tour_item/tour_item_bloc.dart';
import '../../../widgets/comment_item.dart';
import 'rating_bottom_sheet.dart';

class RatingTab extends StatefulWidget {

  const RatingTab({
    Key? key,
  }) : super(key: key);

  @override
  State<RatingTab> createState() => _RatingTabState();
}

class _RatingTabState extends State<RatingTab> {

  @override
  Widget build(BuildContext context) {
    var profileBloc = context.read<ProfileBloc>();
    var ratingBloc = context.read<RatingBloc>();
    var tourItemBloc = context.read<TourItemBloc>();

    return BlocBuilder<RatingBloc,RatingState>(
      buildWhen: (previous, current) => current is GetRatingListState,
      builder: (context,state) =>
      Scaffold(
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ratingBloc.ratingByCustomer == null ?
                    Text(
                      '0.0',
                      style: GoogleFonts.lato(
                        fontSize: 60.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue[900],
                      ),
                    ) :
                    Text(
                      ratingBloc.ratingByCustomer!.toStringAsFixed(1),
                      style: GoogleFonts.lato(
                        fontSize: 60.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue[900],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ratingBloc.FiveStarRatingList!=null ?
                      "⭐⭐⭐⭐⭐  ${ratingBloc.FiveStarRatingList.toString()}" : "⭐⭐⭐⭐⭐  0",
                      style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      ratingBloc.FourStarRatingList!=null ?
                      "⭐⭐⭐⭐  ${ratingBloc.FourStarRatingList.toString()}" : "⭐⭐⭐⭐  0",
                      style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      ratingBloc.ThreeStarRatingList!=null ?
                      "⭐⭐⭐  ${ratingBloc.ThreeStarRatingList.toString()}" : "⭐⭐⭐  0",
                      style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      ratingBloc.TwoStarRatingList!=null ?
                      "⭐⭐  ${ratingBloc.TwoStarRatingList.toString()}" : "⭐⭐  0",
                      style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      ratingBloc.OneStarRatingList!=null ?
                      "⭐  ${ratingBloc.OneStarRatingList.toString()}" : "⭐  0",
                      style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
              BlocBuilder<RatingBloc,RatingState>(
                buildWhen: (previous, current) =>previous is GetRatingListState || current is GetRatingListState,
                builder: (context,state) =>
                state is GetRatingListState ?
                  state.getRatingSuccess == true ?
                    ListView.builder(
                     shrinkWrap: true,
                     physics: const ClampingScrollPhysics(),
                     reverse: true,
                     padding: const EdgeInsets.all(10.0),
                     itemCount: ratingBloc.listRating!.length,
                     itemBuilder: (BuildContext context, int index) {
                    return
                      MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: profileBloc,
                          ),
                          BlocProvider.value(
                            value: ratingBloc,
                          ),
                          BlocProvider.value(
                            value: tourItemBloc,),
                          BlocProvider<RatingItemBloc>(create: (context) => RatingItemBloc()..add(GetRatingItemEvent(rating: ratingBloc.listRating![index]))),
                        ],
                          child: CommentItem(index: index,));
                  },
            )
                    :
              Center(
                 child: Container(
                 margin: const EdgeInsets.only(top: 40.0),
                 child: const Text('No rating yet'),),
              )
            :
              const Center(
                child: CircularProgressIndicator(),
              )
          ),]
        ),
        floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(
                    FontAwesomeIcons.pen,
                    color: Colors.white,),
                onPressed: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.0),
                        ),
                      ),
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            child:
                            RatingBottomSheet(
                                callbackSubmitComment:(rating,comment) {
                                  ratingBloc.add(CreateRatingEvent(
                                      serviceId: tourItemBloc.tour!.id!,
                                      userId: profileBloc.user!.id,
                                      content: comment,
                                      rating: rating.toDouble(),
                                      type: 'tour'
                                  ));
                                  ratingBloc.add(GetRatingListEvent(
                                      page: 1,
                                      serviceId: tourItemBloc.tour!.id!,
                                      type: 'tour'
                                  ));
                                }
                          ),
                        ),);
                      });
                },
              )
      ),
    );
  }
}
