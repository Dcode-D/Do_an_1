import 'package:doan1/BLOC/hotel_booking/hotel_booking_bloc.dart';
import 'package:doan1/BLOC/profile/profile_view/profile_bloc.dart';
import 'package:doan1/BLOC/screen/book_history/book_history_bloc.dart';
import 'package:doan1/BLOC/widget_item/hotel_item/hotel_item_bloc.dart';
import 'package:doan1/screens/detail_screens/hotel/hotel_book_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HotelDetailScreen extends StatefulWidget{
  final int type;

  const HotelDetailScreen({
    Key? key,
    required this.type
  }) : super(key: key);

  @override
  _HotelDetailScreenState createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  final PageController listController = PageController();

  @override
  Widget build(BuildContext context) {
    var hotelItemBloc = context.read<HotelItemBloc>();
    hotelItemBloc.add(GetHotelIsFavorite());
    var profileBloc = context.read<ProfileBloc>();
    var bookHistoryBloc = context.read<BookHistoryBloc>();
    final formatCurrency = NumberFormat("#,###");
    return BlocBuilder<HotelItemBloc,HotelItemState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context,state)=>
        SafeArea(
          child: Scaffold(
          body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  hotelItemBloc.hotel == null ? Container() :
                  Hero(tag: hotelItemBloc.hotel!.id.toString(),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.45,
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
                              itemCount: hotelItemBloc.listImage!.length,
                              itemBuilder:(context, index) {
                                return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0.0, 8.0),
                                            blurRadius: 10.0,
                                          ),
                                        ],
                                        image: DecorationImage(
                                            image: NetworkImage(hotelItemBloc.listImage![index]),
                                            fit: BoxFit.cover
                                        )
                                    )// image:AssetImage(url),),
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
                              color: Colors.black.withOpacity(0.3)
                            ),
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
                  const SizedBox(height: 10.0),
                  hotelItemBloc.listImage == null ? const Center(child: CircularProgressIndicator(),) :
                  Center(
                    child: Container(
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
                        count: hotelItemBloc.listImage!.length,
                        effect: const ExpandingDotsEffect(
                          activeDotColor: Colors.orange,
                          dotColor: Color(0xFFababab),
                          dotHeight: 4.8,
                          dotWidth: 6,
                          spacing: 4.8,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              hotelItemBloc.hotel == null ? 'Loading...' :
                              hotelItemBloc.hotel!.name!,
                              style: GoogleFonts.raleway(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            hotelItemBloc.hotel?.maxPrice !=null && hotelItemBloc.hotel?.minPrice !=null?
                            Flexible(
                              flex: 3,
                              child: Text(
                                "${formatCurrency.format((hotelItemBloc.hotel!.maxPrice! + hotelItemBloc.hotel!.minPrice!)/2)} VNĐ / Night",
                                style: GoogleFonts.raleway(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ) : const Text('Loading...'),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            const Icon(FontAwesomeIcons.mapMarkerAlt, size: 18.0, color: Colors.grey),
                            const SizedBox(width: 5.0),
                            Flexible(
                              child: Text(
                                hotelItemBloc.hotel == null ? 'Loading...' :
                                hotelItemBloc.hotel!.address!,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.raleway(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        hotelItemBloc.hotel!.facilities!.isEmpty ? const Text('Loading...') :
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hotel facilities",
                              style: GoogleFonts.raleway(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4, crossAxisSpacing: 8.0, mainAxisSpacing: 0
                                ),
                                itemCount: hotelItemBloc.hotel!.facilities!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(width: 1,
                                          color: Colors.grey.withOpacity(0.5)),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 5.0,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        _buildIconForFacilities(hotelItemBloc.hotel!.facilities![index]),
                                        const SizedBox(height: 5.0),
                                        Text(
                                          hotelItemBloc.hotel!.facilities![index],
                                          style: GoogleFonts.raleway(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Text("Description",
                          style: GoogleFonts.raleway(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),),
                        const SizedBox(height: 10.0),
                        Text(
                          hotelItemBloc.hotel == null ? 'Loading...' :
                          hotelItemBloc.hotel!.description!,
                          softWrap: true,
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.raleway(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  )
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
                            BlocProvider<ProfileBloc>.value(
                                value: profileBloc),
                            BlocProvider<HotelBookingBloc>(
                                create: (context) => HotelBookingBloc()),
                            BlocProvider<HotelItemBloc>.value(
                              value: hotelItemBloc,
                            ),
                            BlocProvider<BookHistoryBloc>.value(value: bookHistoryBloc),
                          ],
                          child: const HotelBookingInfoScreen())
                  ));
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 2),
                  width: MediaQuery.of(context).size.width * 0.6,
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
              BlocBuilder<HotelItemBloc,HotelItemState>(
                buildWhen: (previous, current) => current is HotelItemGetFavoriteState,
                builder:(context,state) =>
                state is HotelItemGetFavoriteState ?
                  state.getHotelFavoriteSuccess == false ?
                    InkWell(
                      onTap: () {
                        hotelItemBloc.add(LikeHotelEvent(userId: profileBloc.user!.id));
                        hotelItemBloc.add(GetHotelIsFavorite());
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
                      hotelItemBloc.add(DislikeHotelEvent());
                      hotelItemBloc.add(GetHotelIsFavorite());
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
        ),
    );
  }
    Icon _buildIconForFacilities(String index) {
    switch (index) {
      case 'Wifi' || 'wifi':
        return const Icon(FontAwesomeIcons.wifi, size: 18.0, color: Colors.grey);
      case 'Pool' || 'pool':
        return const Icon(FontAwesomeIcons.swimmingPool, size: 18.0, color: Colors.grey);
      case 'Utility' || 'utility':
        return const Icon(FontAwesomeIcons.utensils, size: 18.0, color: Colors.grey);
      case 'Bed' || 'bed':
        return const Icon(FontAwesomeIcons.bed, size: 18.0, color: Colors.grey);
      case 'Bathroom' || 'bathroom':
        return const Icon(FontAwesomeIcons.bath, size: 18.0, color: Colors.grey);
      case 'Car' || 'car':
        return const Icon(FontAwesomeIcons.car, size: 18.0, color: Colors.grey);
      case 'Gym' || 'gym':
        return const Icon(FontAwesomeIcons.dumbbell, size: 18.0, color: Colors.grey);
      case 'Bar' || 'bar':
        return const Icon(FontAwesomeIcons.wineGlassAlt, size: 18.0, color: Colors.grey);
      case 'TV' || 'tv' || 'Television' || 'television':
        return const Icon(FontAwesomeIcons.tv, size: 18.0, color: Colors.grey);
      case 'Air conditioner' || 'air conditioner':
        return const Icon(FontAwesomeIcons.thermometerHalf, size: 18.0, color: Colors.grey);
      case 'Smoking' || 'smoking' || 'Smoke' || 'smoke' || 'Smoking allowed' || 'smoking allowed':
        return const Icon(FontAwesomeIcons.smoking, size: 18.0, color: Colors.grey);
      case 'Pet' || 'pet' || 'Pet allowed' || 'pet allowed':
        return const Icon(FontAwesomeIcons.dog, size: 18.0, color: Colors.grey);
      default:
        return const Icon(FontAwesomeIcons.add, size: 18.0, color: Colors.grey);
    }
  }
}