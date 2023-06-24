import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../BLOC/profile/profile_view/profile_bloc.dart';
import '../../../BLOC/widget_item/tour_item/tour_item_bloc.dart';
import '../../../models/tour_model.dart';

class DetailTab extends StatelessWidget {

  DetailTab({Key? key}) : super(key: key);

  final formatCurrency = NumberFormat("#,###");


  @override
  Widget build(BuildContext context) {
    var tourItemBloc = context.read<TourItemBloc>();
    tourItemBloc.add(GetTourIsFavorite());
    var profileBloc = context.read<ProfileBloc>();
    return BlocBuilder<TourItemBloc,TourItemState>(
      builder: (context,state) => Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(0.0),
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // rating
                      Container(
                        width: 100,
                        padding: const EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Rating",
                              style: GoogleFonts.lato(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Theme.of(context).primaryColor,
                                  size: 14.0,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  tourItemBloc.tour != null ?
                                  tourItemBloc.tour!.rating.toString() : "0.0",
                                  style: GoogleFonts.roboto(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              '3 reviews',
                              style: const TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                      // price
                      Container(
                        padding: const EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Price",
                              style: GoogleFonts.lato(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.dollarSign,
                                  color: Theme.of(context).primaryColor,
                                  size: 14.0,
                                ),
                                Text(
                                  tourItemBloc.tour != null ?
                                  formatCurrency.format(tourItemBloc.tour!.price) : "0",
                                  style: GoogleFonts.roboto(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            const Text(
                              "vnd",
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                      // visit
                      Container(
                        width: 100,
                        padding: const EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Visit",
                              style: GoogleFonts.lato(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Theme.of(context).primaryColor,
                                  size: 16.0,
                                ),
                                Text(
                                  tourItemBloc.tour != null ?
                                  tourItemBloc.tour!.articles!.length.toString() : "0",
                                  style: GoogleFonts.roboto(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            const Text(
                              "locations",
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: GoogleFonts.lato(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        tourItemBloc.tour != null ?
                        tourItemBloc.tour!.description! : "",
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar:
        BlocBuilder<TourItemBloc,TourItemState>(
          bloc: tourItemBloc,
          buildWhen: (previous, current) => current is TourItemGetFavoriteState,
          builder: (context,state)
          =>
          state is TourItemGetFavoriteState ?
            state.getTourFavoriteSuccess == false ?
              InkWell(
                onTap: () {
                  tourItemBloc.add(LikeTourEvent(userId: profileBloc.user!.id));
                  tourItemBloc.add(GetTourIsFavorite());
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 2),
                  width: double.infinity,
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Like this tour",
                        style: GoogleFonts.roboto(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      const Icon(
                        FontAwesomeIcons.angleDoubleRight,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              )
                :
              InkWell(
              onTap: () {
                tourItemBloc.add(DislikeTourEvent());
                tourItemBloc.add(GetTourIsFavorite());
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 2),
                width: double.infinity,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Unlike this tour",
                      style: GoogleFonts.roboto(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    const Icon(
                      FontAwesomeIcons.angleDoubleRight,
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),
            )
              :
            const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
