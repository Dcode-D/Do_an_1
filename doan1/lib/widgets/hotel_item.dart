
import 'package:doan1/BLOC/screen/book_history/book_history_bloc.dart';
import 'package:doan1/BLOC/widget_item/hotel_item/hotel_item_bloc.dart';
import 'package:doan1/screens/detail_screens/hotel/hotel_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../BLOC/profile/profile_view/profile_bloc.dart';
import '../BLOC/widget_item/rating/rating_bloc.dart';

class HotelItem extends StatelessWidget{
  final int type;

  HotelItem({
    Key? key,
    required this.type
  }) : super(key: key);

  final formatCurrency = NumberFormat("#,###");

  @override
  Widget build(BuildContext context){
    var hotelItemBloc = context.read<HotelItemBloc>();
    var profileBloc = context.read<ProfileBloc>();
    var bookHistoryBloc = context.read<BookHistoryBloc>();
    return BlocBuilder<HotelItemBloc,HotelItemState>(
      builder:(context,state) =>
      SizedBox(
        height: type == 1 ? 280 : 300,
        child: GestureDetector(
          onTap: ()
          =>
              Navigator.of(context).push(
              MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: profileBloc),
                  BlocProvider.value(value: hotelItemBloc),
                  BlocProvider.value(value: bookHistoryBloc),
                  BlocProvider<RatingBloc>(create: (context) =>
                  RatingBloc()..add(GetRatingListEvent(
                      page: 1,
                      serviceId: hotelItemBloc.hotel!.id,
                      type: 'hotel')))
                ],
                child: HotelDetailScreen(
                  type: type,
                ),
              ),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.all(10.0),
            width: type == 1 ? 250.0 : 270.0,
            height: type == 1 ? 260.0 : 265.0,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Positioned(
                  bottom: 0.0,
                  child: Container(
                    height: type == 1 ? 130.0 : 160.0,
                    width: type == 1 ? 240.0 : 320.0,
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
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            hotelItemBloc.hotel!=null? hotelItemBloc.hotel!.name as String :"loading...",
                            style: TextStyle(
                              fontSize: type == 1 ? 20.0 : 22.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            hotelItemBloc.hotel!=null? '${hotelItemBloc.hotel!.province!}, ${hotelItemBloc.hotel!.city}' :"loading...",
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                              hotelItemBloc.hotel?.maxPrice !=null && hotelItemBloc.hotel?.minPrice !=null?
                            '${formatCurrency.format((hotelItemBloc.hotel!.maxPrice! + hotelItemBloc.hotel!.minPrice!)/2)} VNĐ / night':'?',
                            style: TextStyle(
                              fontSize: type == 1 ? 18.0 : 20.0,
                              fontWeight: FontWeight.w600,
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
                  child:
                  hotelItemBloc.hotel != null?
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child:
                          FadeInImage(
                            height: type == 1 ? 180.0 : 185.0,
                            width: type == 1 ? 220.0 : 260.0,
                            imageErrorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return SizedBox(
                                  width: type == 1 ? 220.0 : 260.0,
                                  height: type == 1 ? 180.0 : 185.0,
                                  child: const Center(child: Icon(Icons.error)));
                            },
                            image:
                        NetworkImage(hotelItemBloc.hotel!=null && hotelItemBloc.listImage!.isNotEmpty ? hotelItemBloc.listImage![0]: ""),
                            placeholder: const AssetImage('assets/images/loading.gif'),
                            fit: BoxFit.cover,
                          ),
                  ):
                      const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}