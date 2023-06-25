import 'package:doan1/BLOC/vehicle_booking/vehicle_booking_bloc.dart';
import 'package:doan1/BLOC/widget_item/car_item/car_item_bloc.dart';
import 'package:doan1/screens/detail_screens/vehicle/vehicle_book_info_screen.dart';
import 'package:doan1/screens/detail_screens/vehicle/vehicle_comment_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../BLOC/profile/profile_view/profile_bloc.dart';
import '../../../BLOC/screen/book_history/book_history_bloc.dart';
import '../../../BLOC/widget_item/rating/rating_bloc.dart';
import '../../../BLOC/widget_item/rating_item/rating_item_bloc.dart';
import '../tour/rating_bottom_sheet.dart';


class VehicleRentDetailScreen extends StatefulWidget{
  final int type;

  const VehicleRentDetailScreen({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  _VehicleRentDetailScreenState createState() => _VehicleRentDetailScreenState();
}

class _VehicleRentDetailScreenState extends State<VehicleRentDetailScreen>{
  final PageController listController = PageController();
  final formatCurrency = NumberFormat("#,###");
  @override
  Widget build(BuildContext context) {
    var carItemBloc = context.read<CarItemBloc>();
    carItemBloc.add(GetCarIsFavorite());
    var profileBloc = context.read<ProfileBloc>();
    var bookHistoryBloc = context.read<BookHistoryBloc>();
    var ratingBloc = context.read<RatingBloc>();
    return BlocBuilder<CarItemBloc,CarItemState>(
        buildWhen: (previous, current) => previous != current,
      builder: (context,state) =>
      SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                carItemBloc.vehicle != null ?
                Hero(
                  tag: carItemBloc.vehicle!.id.toString(),
                  child: Stack(
                    children:<Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.375,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
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
                          itemCount: carItemBloc.vehicle!.images!.length,
                          itemBuilder:(context, index) {
                            return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0.0, 8.0),
                                        blurRadius: 10.0,
                                      ),
                                    ],
                                    image: DecorationImage(
                                        image: NetworkImage(carItemBloc.listImage![index]),
                                        fit: BoxFit.cover
                                    )
                                )// image:AssetImage(url),),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 40.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black.withOpacity(0.3)
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new_rounded),
                            color: Colors.white,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ]
                  ),
                )
                    : const Center(child: CircularProgressIndicator()),
                const SizedBox(height: 10.0),
                Center(
                  child:
                  carItemBloc.vehicle != null ?
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
                      count: carItemBloc.vehicle!.images!.length,
                      effect: const ExpandingDotsEffect(
                        activeDotColor: Colors.orange,
                        dotColor: Color(0xFFababab),
                        dotHeight: 4.8,
                        dotWidth: 6,
                        spacing: 4.8,
                      ),
                    ),
                  ) : const SizedBox(),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 5,
                            child: Row(
                              children:[
                                const Icon(Icons.directions_car, size: 25.0, color: Colors.grey),
                                const SizedBox(width: 10.0),
                                Text(
                                  carItemBloc.vehicle!.brand!,
                                  style: GoogleFonts.raleway(
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ]
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            child: Text("${formatCurrency.format(carItemBloc.vehicle!.pricePerDay!)} VNĐ / Day",
                              style: GoogleFonts.raleway(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,),),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          const Icon(Icons.airline_seat_legroom_extra_sharp, size: 25.0, color: Colors.grey),
                          const SizedBox(width: 10.0),
                          Text(
                            '${carItemBloc.vehicle!.seats!} Seats',
                            style: GoogleFonts.raleway(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            carItemBloc.vehicle!.color!,
                            style: GoogleFonts.raleway(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          const Icon(FontAwesomeIcons.paintBrush, size: 25.0, color: Colors.grey),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 25.0, color: Colors.grey),
                          const SizedBox(width: 10.0),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Text(
                              carItemBloc.vehicle!.address??'',
                              style: GoogleFonts.raleway(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          const Icon(FontAwesomeIcons.info, size: 25.0, color: Colors.grey),
                          const SizedBox(width: 10.0),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Text(
                              carItemBloc.vehicle!.description!,
                              style: GoogleFonts.raleway(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Reviews",
                                style: GoogleFonts.raleway(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),),
                              const Spacer(),
                              TextButton(
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
                                                      serviceId: carItemBloc.vehicle!.id!,
                                                      userId: profileBloc.user!.id,
                                                      content: comment,
                                                      rating: rating.toDouble(),
                                                      type: 'car'
                                                  ));
                                                  ratingBloc.add(GetRatingListEvent(
                                                      page: 1,
                                                      serviceId: carItemBloc.vehicle!.id!,
                                                      type: 'car'
                                                  ));
                                                }
                                            ),
                                          ),);
                                      });
                                },
                                child: Text("Add reviews",
                                  style: GoogleFonts.raleway(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          BlocBuilder<RatingBloc,RatingState>(
                            buildWhen: (previous, current) =>previous is GetRatingListState || current is GetRatingListState,
                            builder: (context,state) => Row(
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
                                            value: carItemBloc,),
                                          BlocProvider<RatingItemBloc>(create: (context) => RatingItemBloc()..add(GetRatingItemEvent(rating: ratingBloc.listRating![index]))),
                                        ],
                                        child: VehicleCommentItem(index: index,));
                                },
                              )
                                  :
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 40.0),
                                  child: const Text('No rating yet',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),),
                                  ),
                              )
                                  :
                              const Center(
                                child: CircularProgressIndicator(),
                              )
                          ),
                          const SizedBox(
                            height: 50.0,)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar:
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: carItemBloc),
                          BlocProvider.value(value: profileBloc),
                          BlocProvider.value(value: bookHistoryBloc),
                          BlocProvider<VehicleBookingBloc>(
                              create: (context) => VehicleBookingBloc())
                        ],
                          child: VehicleRentBookInfoScreen())));
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 2),
                  width: MediaQuery.of(context).size.width*0.6,
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Book now",
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
              ),

              BlocBuilder<CarItemBloc,CarItemState>(
                buildWhen: (previous, current) => current is CarItemGetFavoriteState,
                builder:(context,state) =>
                state is CarItemGetFavoriteState ?
                state.getCarFavoriteSuccess == false ?
                InkWell(
                  onTap: () {
                    carItemBloc.add(LikeCarEvent(userId: profileBloc.user!.id));
                    carItemBloc.add(GetCarIsFavorite());
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 2),
                    width: MediaQuery.of(context).size.width * 0.32,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Theme.of(context).primaryColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Like",
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        const Icon(
                          FontAwesomeIcons.solidHeart,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
                    :
                InkWell(
                  onTap: () {
                    carItemBloc.add(DislikeCarEvent());
                    carItemBloc.add(GetCarIsFavorite());
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 2),
                    width: MediaQuery.of(context).size.width * 0.32,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dislike",
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Icon(
                          FontAwesomeIcons.heart,
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  ),
                )
                    :
                const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      )
    );
  }

}