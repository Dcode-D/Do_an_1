import 'package:doan1/BLOC/widget_item/car_item/car_item_bloc.dart';
import 'package:doan1/screens/detail_screens/vehicle/vehicle_rent_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../BLOC/profile/profile_view/profile_bloc.dart';
import '../../../BLOC/screen/book_history/book_history_bloc.dart';
import '../../../BLOC/widget_item/rating/rating_bloc.dart';

class VehicleItemForAll extends StatelessWidget{
  final int type;

  VehicleItemForAll({
    required this.type,
    Key? key,
  }) : super(key: key);

  final formatCurrency = NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    var carItemBloc = context.read<CarItemBloc>();
    var profileBloc = context.read<ProfileBloc>();
    var bookHistoryBloc = context.read<BookHistoryBloc>();
    return BlocBuilder<CarItemBloc,CarItemState>(
      builder: (context,state) =>
      carItemBloc.vehicle != null ?
      GestureDetector(
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: profileBloc),
                  BlocProvider.value(value: carItemBloc),
                  BlocProvider.value(value: bookHistoryBloc),
                  BlocProvider<RatingBloc>(create: (context) =>
                  RatingBloc()..add(GetRatingListEvent(
                      page: 1,
                      serviceId: carItemBloc.vehicle!.id,
                      type: 'car')))
                ],
                child: VehicleRentDetailScreen(
                  type: type,
                ),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Hero(
                tag: carItemBloc.vehicle!.id.toString(),
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      child: FadeInImage(
                          placeholder: const AssetImage('assets/images/loading.gif'),
                          image: NetworkImage(carItemBloc.vehicle!=null && carItemBloc.listImage!.isNotEmpty ? carItemBloc.listImage![0]: ""),
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                FontAwesomeIcons.image,
                                color: Colors.grey,
                                size: 50,
                              ),
                            );
                          }
                      ),
                    ),
                    Positioned(
                      top: 10.0,
                      left: 10.0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 5.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.orange,
                        ),
                        child: Text(
                          'Vehicle',
                          style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )
                        ),
                      ),
                    ),
                    Positioned.fill(
                      right: 10.0,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                            carItemBloc.vehicle!.brand != null ? carItemBloc.vehicle!.brand! : 'Loading...',
                          style: GoogleFonts.raleway(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            color: Colors.white,
                          )
                        ),
                      ),),
                    Positioned(
                      left: 10.0,
                      bottom: 10.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Icon(
                                FontAwesomeIcons.moneyBill,
                                size: 16.0,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                carItemBloc.vehicle!.pricePerDay != null ?
                                '${formatCurrency.format(carItemBloc.vehicle!.pricePerDay)} VND / Day' : 'Loading...',
                                style: GoogleFonts.raleway(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                  color: Colors.white,
                                )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 10.0,
                      top: 15.0,
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            size: 16.0,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 2.0),
                          Text(
                            carItemBloc.vehicle!.province != null && carItemBloc.vehicle!.city != null ?
                                carItemBloc.vehicle!.city!.length < 10 ?
                            '${carItemBloc.vehicle!.province!}, ${carItemBloc.vehicle!.city!}' :
                            '${carItemBloc.vehicle!.province!}, ${carItemBloc.vehicle!.city!.substring(0,10)}...' :
                            'Loading...',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          ),
        ),
      ) :
      const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}