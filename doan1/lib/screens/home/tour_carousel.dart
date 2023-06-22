
import 'package:doan1/BLOC/widget_item/tour_item/tour_item_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:doan1/widgets/tour_item.dart';

import '../../BLOC/profile/profile_view/profile_bloc.dart';
import '../../BLOC/screen/all_screen/all_tour/all_tour_bloc.dart';
import '../../models/tour_model.dart';
import '../all/all_tour_screen.dart';

class TourCarousel extends StatelessWidget {

  final PageController listController = PageController();

  @override
  Widget build(BuildContext context) {
    var profileBloc = context.read<ProfileBloc>();
    var allTourBloc = context.read<AllTourBloc>();
    return BlocBuilder<AllTourBloc,AllTourState>(
      builder: (context,state) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Top Tours',
                  style: GoogleFonts.raleway(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider<ProfileBloc>.value(
                            value: profileBloc,
                          ),
                          BlocProvider<AllTourBloc>(
                            create: (_) => AllTourBloc()..add(GetTourListEvent()),
                          ),
                        ],
                        child: AllTourScreen())));
                  },
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
          SizedBox(
            height: 320.0,
            child:
            allTourBloc.listTour != null ?
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: listController,
              scrollDirection: Axis.horizontal,
              itemCount: allTourBloc.listTour!.length,
              itemBuilder: (BuildContext context, int index) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<ProfileBloc>.value(value: profileBloc),
                    BlocProvider<TourItemBloc>(
                      create: (_) => TourItemBloc()..add(GetTourItemEvent(tourId: allTourBloc.listTour![index].id)),
                    )
                  ],
                    child: TourItem( type: 1));
              },
            ) : const Center(child: CircularProgressIndicator()),
          ),
          state.getListTourSuccess == true?
          SmoothPageIndicator(
              controller: listController,
              count: (allTourBloc.listTour!.length/2).round(),
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.orange,
                dotColor: Color(0xFFababab),
                dotHeight: 4.8,
                dotWidth: 6,
                spacing: 4.8,
              )
          ) : const Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }
}
