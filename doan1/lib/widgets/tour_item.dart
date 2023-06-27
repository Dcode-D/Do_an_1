import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../BLOC/profile/profile_view/profile_bloc.dart';
import '../BLOC/widget_item/tour_item/tour_item_bloc.dart';
import '../screens/detail_screens/tour/tour_detail_screen.dart';

class TourItem extends StatelessWidget {
  final int type;

  TourItem({
    Key? key,
    required this.type,
  }) : super(key: key);

  final formatCurrency = NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    var tourItemBloc = context.read<TourItemBloc>();
    var profileBloc = context.read<ProfileBloc>();
    return BlocBuilder<TourItemBloc,TourItemState>(
      builder: (context,state) =>
      SizedBox(
        height: type == 1 ? 300 : 330,
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers:[
                  BlocProvider.value(value: profileBloc),
                  BlocProvider.value(value: tourItemBloc),
                ],
                child: TourDetailScreen(
                  type: type,
                ),
              ),
            ),
          ),
          // main container
          child: Container(
            margin: const EdgeInsets.all(10.0),
            width: type == 1 ? 240.0 : 300.0,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Positioned(
                  bottom: 15.0,
                  child: Container(
                    height: type == 1 ? 120.0 : 150.0,
                    width: type == 1 ? 240.0 : 320.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tourItemBloc.tour != null ?
                            '${tourItemBloc.tour!.articles!.length} locations' : '0 locations',
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            tourItemBloc.tour != null ?
                            tourItemBloc.tour!.maxGroupSize! > 1 ?
                            'Tour for ${tourItemBloc.tour!.maxGroupSize!.toInt()} people' :
                            'Tour for ${tourItemBloc.tour!.maxGroupSize!.toInt()} person' : 'Max 0 person',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          Text(
                            tourItemBloc.tour != null ?
                            '${tourItemBloc.tour!.description}' : 'Tour description',
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      tourItemBloc.listImage != null && tourItemBloc.tour != null?
                          tourItemBloc.listImage!.isNotEmpty ?
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: FadeInImage(
                          height: type == 1 ? 180.0 : 185.0,
                          width: type == 1 ? 220.0 : 260.0,
                          imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                          image:
                          NetworkImage(tourItemBloc.listImage![0]),
                          placeholder: const AssetImage('assets/images/loading.gif'),
                          fit: BoxFit.cover,
                        ),
                      ): const Center(child: CircularProgressIndicator()) : const Center(child: CircularProgressIndicator()),
                      Positioned(
                        left: 10.0,
                        bottom: 10.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              tourItemBloc.tour != null ?
                              '${tourItemBloc.tour!.name}' : 'Tour name',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: type == 1 ? 24.0 : 28.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.moneyBill,
                                      size: type == 1 ? 12.0 : 16.0,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 5.0),
                                    Text(
                                      tourItemBloc.tour != null ?
                                      '${
                                        formatCurrency.format(
                                            tourItemBloc.tour!.price)
                                      } VNĐ' : '0',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: type == 1 ? 12.0 : 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 65.0),
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.solidStar,
                                      size: type == 1 ? 12.0 : 16.0,
                                      color: Colors.yellow,
                                    ),
                                    const SizedBox(width: 5.0),
                                    Text(
                                      tourItemBloc.tour != null ?
                                      '${tourItemBloc.tour!.rating}' : '0',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: type == 1 ? 14.0 : 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
