import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../BLOC/profile/profile_view/profile_bloc.dart';
import '../../../BLOC/widget_item/tour_item/tour_item_bloc.dart';
import '../../detail_screens/tour/tour_detail_screen.dart';

class TourItemForAll extends StatelessWidget{

  TourItemForAll({
    Key? key,
  }) : super(key: key);

  final formatCurrency = NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    var profileBloc = context.read<ProfileBloc>();
    var tourItemBloc = context.read<TourItemBloc>();
    return BlocBuilder<TourItemBloc,TourItemState>(
      builder: (context,state) =>
      tourItemBloc.tour != null ?
          GestureDetector(
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: profileBloc),
                  BlocProvider.value(value: tourItemBloc),],
                child: TourDetailScreen(
                  type: 1,
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
              tag: tourItemBloc.tour!.id!,
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    child: FadeInImage(
                        placeholder: const AssetImage('assets/images/loading.gif'),
                        image: NetworkImage(tourItemBloc.tour!=null && tourItemBloc.listImage!.isNotEmpty ? tourItemBloc.listImage![0]: ""),
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
                        child:Text(
                        'Tour',
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    right: 10.0,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          tourItemBloc.tour != null ? tourItemBloc.tour!.name! : "Loading...",
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
                              tourItemBloc.tour != null ? '${formatCurrency.format(tourItemBloc.tour!.price)} VND' :
                              'Loading...',
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
                    right: 15.0,
                    bottom: 10.0,
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            size: 16.0,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 2.0),
                          Text(
                            tourItemBloc.tour != null ? '${tourItemBloc.tour!.articles!.length} locations' :
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
      ) : const Center(child: CircularProgressIndicator(),),
    );
  }

}