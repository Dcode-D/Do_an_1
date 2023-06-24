import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../BLOC/profile/profile_view/profile_bloc.dart';
import '../../../BLOC/widget_item/rating/rating_bloc.dart';
import '../../../BLOC/widget_item/tour_item/tour_item_bloc.dart';
import '../../../models/destination_model.dart';
import '../../../models/tour_model.dart';
import '../../../widgets/planning_item.dart';
import 'detail_tab.dart';
import 'rating_tab.dart';

class TourDetailScreen extends StatefulWidget {
  final int type;

  const TourDetailScreen({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  _TourDetailScreenState createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageController listController = PageController();
  String province = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tourItemBloc = context.read<TourItemBloc>();
    var profileBloc = context.read<ProfileBloc>();
    _tabController.addListener(() {
      if(tourItemBloc.tour != null) {
        tourItemBloc.add(GetTourItemEvent(tourId: tourItemBloc.tour!.id));
      }
    });

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Hero(
              tag: tourItemBloc.tour!.id.toString(),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 8.0),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: PageView.builder(
                      controller: listController,
                      itemCount: tourItemBloc.listImage!.length,
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 10.0,
                                  ),
                                ],
                                image: DecorationImage(
                                    image: NetworkImage(
                                        tourItemBloc.listImage![index]),
                                    fit: BoxFit
                                        .cover)) // image:AssetImage(url),),
                            );
                      },
                    ),
                  ),
                  // buttons row
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 40.0),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black.withOpacity(0.3)),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        color: Colors.white,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  // name and province
                ],
              ),
            ),
            tourItemBloc.tour != null ?
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: SmoothPageIndicator(
                controller: listController,
                count: tourItemBloc.listImage!.length,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Colors.orange,
                  dotColor: Color(0xFFababab),
                  dotHeight: 4.8,
                  dotWidth: 6,
                  spacing: 4.8,
                ),
              ),
            ) : const SizedBox(),
            DefaultTabController(
              length: 3,
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.orange[800],
                unselectedLabelColor: Colors.grey,
                labelStyle: GoogleFonts.lato(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: GoogleFonts.lato(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Colors.orange[800]!,
                  ),
                  insets: const EdgeInsets.symmetric(horizontal: 75.0),
                ),
                tabs: const [
                  Tab(child: Text("Details")),
                  Tab(child: Text("Plan")),
                  Tab(child: Text("Rating")),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // description section
                  MultiBlocProvider(providers: [
                    BlocProvider.value(value: profileBloc),
                    BlocProvider.value(value: tourItemBloc),
                  ], child: DetailTab()),
                  // planning section
                  BlocBuilder<TourItemBloc, TourItemState>(
                      buildWhen: (previous, current) =>
                          current is GetTourItemState,
                      builder: (context, state) =>
                      (state is GetTourItemState)?
                      state.getTourItemSuccess == true
                          ? ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(15.0),
                              itemCount: tourItemBloc.tour!.articles!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(value: tourItemBloc),
                                  ],
                                  child: PlanningItem(
                                    index: index,
                                    type: 1,
                                  ),
                                );
                              },
                            )
                          : const Center(child: CircularProgressIndicator())
                          :
                      const Center(child: CircularProgressIndicator())
                  ),
                  MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: profileBloc),
                        BlocProvider(
                          create: (context) => RatingBloc()..add(GetRatingListEvent(
                              page: 1,
                              serviceId: tourItemBloc.tour!.id,
                              type: 'tour')),
                        ),
                        BlocProvider.value(value: tourItemBloc)
                      ],
                      child: RatingTab()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
