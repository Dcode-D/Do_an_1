import 'dart:convert';
import 'package:doan1/screens/detail_screens/tour/edit_rating_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../BLOC/profile/profile_view/profile_bloc.dart';
import '../BLOC/widget_item/rating/rating_bloc.dart';
import '../BLOC/widget_item/rating_item/rating_item_bloc.dart';
import '../BLOC/widget_item/tour_item/tour_item_bloc.dart';
import '../data/model/rating.dart';
import '../data/model/user.dart';
import '../models/comment_model.dart';
import '../models/customer_model.dart';

class CommentItem extends StatelessWidget {
  int? index;
  CommentItem({this.index});

  @override
  Widget build(BuildContext context) {
    var ratingItemBloc = context.read<RatingItemBloc>();
    var ratingBloc = context.read<RatingBloc>();
    var tourItemBloc = context.read<TourItemBloc>();
    var profileBloc = context.read<ProfileBloc>();

  String displayRating() {
    String rating = '';
    for (int i = 0; i < ratingItemBloc.rating!.rating!; i++) {
      rating += '⭐';
    }
    return rating;
  }
  return BlocBuilder<RatingItemBloc,RatingItemState>(
    builder: (context,state) => Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(10.0),
    child: Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
  // circle avatar
  // CircleAvatar(
  //   radius: 26.0,
  //   backgroundImage: MemoryImage(base64Decode()),
  // ),
        const SizedBox(width: 10),
      Expanded(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ratingItemBloc.user == null ?
            const Center(child: CircularProgressIndicator(),) :
          Text(
            '${ratingItemBloc.user!.lastname} ${ratingItemBloc.user!.firstname}',
            style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            ),
          ),
            const Spacer(),
            ratingItemBloc.user != null ?
                ratingItemBloc.user!.id == profileBloc.user!.id ?
                IconButton(
                    onPressed: (){
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
                                MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(value: profileBloc),
                                    BlocProvider.value(value: ratingItemBloc),
                                  ],
                                  child: EditRatingBottomSheet(
                                      callbackSubmitComment:(rating,comment) {
                                        ratingBloc.add(UpdateRatingEvent(
                                            ratingId: ratingItemBloc.rating!.id!,
                                            content: comment,
                                            rating: rating.toDouble(),
                                        ));
                                        ratingBloc.add(GetRatingListEvent(
                                            page: 1,
                                            serviceId: tourItemBloc.tour!.id!,
                                            type: 'tour'
                                        ));
                                      }
                                  ),
                                ),
                              ),);
                          });
                    },
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(const Size(15, 15)),
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                    ),
                    icon: const Icon(FontAwesomeIcons.penToSquare,
                          color: Colors.orange,
                          size: 18,))
                :
                const SizedBox() :
            const Center(child: CircularProgressIndicator(),),
            ratingItemBloc.user != null ?
            ratingItemBloc.user!.id == profileBloc.user!.id ?
            InkWell(
              onTap:(){
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm'),
                        content: const Text('Are you sure you want to delete this rating?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Hủy'),
                          ),
                          TextButton(
                            onPressed: () {
                              ratingBloc.add(DeleteRatingEvent(
                                index: index!,
                                  ratingId: ratingItemBloc.rating!.id!,
                              ));
                              ratingBloc.add(GetRatingListEvent(
                                  page: 1,
                                  serviceId: tourItemBloc.tour!.id!,
                                  type: 'tour'
                              ));
                              Navigator.of(context).pop();
                            },
                            child: const Text('Xóa'),
                          ),
                        ],
                      );
                    });
              },
              child: const Icon(Icons.delete_outline_outlined,
                color: Colors.red,
                size: 20,),
            )
                :
            const SizedBox() :
            const Center(child: CircularProgressIndicator(),),
        ],
      ),
        const SizedBox(height: 2),
        ratingItemBloc.rating == null ?
          const Center(child: CircularProgressIndicator(),) :
        Text(displayRating()),
        const SizedBox(height: 6),
        ratingItemBloc.rating == null ?
        const Center(child: CircularProgressIndicator(),) :
        Text(ratingItemBloc.rating!.comment!),
        const SizedBox(height: 6),],
      ),
    ),],
    ),
      const SizedBox(height: 10),
      Container(
      width: MediaQuery.of(context).size.width,
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      color: Colors.grey[300],
          ),
        ],
     ),
    ),
    );
  }
}
