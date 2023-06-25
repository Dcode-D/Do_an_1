import 'package:doan1/BLOC/widget_item/car_item/car_item_bloc.dart';
import 'package:doan1/BLOC/widget_item/rating/rating_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../BLOC/profile/profile_view/profile_bloc.dart';
import '../BLOC/screen/book_history/book_history_bloc.dart';
import '../screens/detail_screens/vehicle/vehicle_rent_detail_screen.dart';

class VehicleItem extends StatelessWidget{
  @override
    final int type;

    final formatCurrency = NumberFormat("#,###");

    VehicleItem({
      Key? key,
      required this.type
    }) : super(key: key);

  @override
  Widget build(BuildContext context){
    var carItemBloc = context.read<CarItemBloc>();
    var profileBloc = context.read<ProfileBloc>();
    var bookHistoryBloc = context.read<BookHistoryBloc>();
    return BlocBuilder<CarItemBloc,CarItemState>(
      builder: (context,state)
      => SizedBox(
        height: type == 1 ? 280 : 300,
        child: GestureDetector(
          onTap: ()
          => Navigator.of(context).push(
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
          ),
          child: Container(
            margin: const EdgeInsets.all(10.0),
            width: type == 1 ? 240.0 : 260.0,
            height: type == 1 ? 260.0 : 265.0,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Positioned(
                  bottom: 10,
                  child: Container(
                    height: type == 1 ? 120.0 : 150.0,
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
                            carItemBloc.vehicle!=null? carItemBloc.vehicle!.brand as String :"loading...",
                            style: TextStyle(
                              fontSize: type == 1 ? 18.0 : 20.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            carItemBloc.vehicle!=null? '${carItemBloc.vehicle!.province}, ${carItemBloc.vehicle!.city}' :"loading...",
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            carItemBloc.vehicle!=null? '${formatCurrency.format(carItemBloc.vehicle!.pricePerDay)} VNĐ / day' :"loading...",
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
                  carItemBloc.vehicle!=null ?
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: FadeInImage(
                      height: type == 1 ? 180.0 : 185.0,
                      width: type == 1 ? 220.0 : 260.0,
                      imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                      image:
                      NetworkImage(carItemBloc.vehicle!=null && carItemBloc.listImage!.isNotEmpty ? carItemBloc.listImage![0]: ""),
                      placeholder: const AssetImage('assets/images/loading.gif'),
                      fit: BoxFit.cover,
                    ),
                  ): const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}