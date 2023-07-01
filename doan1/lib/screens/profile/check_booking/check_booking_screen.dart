import 'package:doan1/BLOC/screen/book_history/book_history_bloc.dart';
import 'package:doan1/screens/profile/check_booking/widget/hotel_check_booking_item.dart';
import 'package:doan1/screens/profile/check_booking/widget/vehicle_check_booking_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../BLOC/profile/booker/booker_bloc.dart';
import '../../../BLOC/screen/booking_widget/hotel_booking_item/hotel_booking_item_bloc.dart';
import '../../../BLOC/screen/booking_widget/vehicle_booking_item/vehicle_booking_item_bloc.dart';
import '../../../widgets/circle_indicator.dart';
import '../../../widgets/silver_appbar_delegate.dart';

class CheckBookingScreen extends StatefulWidget{
  const CheckBookingScreen({Key? key}) : super(key: key);

  @override
  _CheckBookingScreenState createState() => _CheckBookingScreenState();
}

class _CheckBookingScreenState extends State<CheckBookingScreen> with SingleTickerProviderStateMixin{
  final ScrollController _scrollController = ScrollController();

  late BookerBloc bookerBloc;
  @override
  void initState() {
    super.initState();
    bookerBloc = context.read<BookerBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
                centerTitle: true,
                floating: true,
                pinned: true,
                snap: false,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                elevation: 0,
                title: Text(
                  'Check Booking',
                  style: GoogleFonts.raleway(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ];
          },
          body: BlocBuilder<BookerBloc,BookerState>(
            builder: (context, state) =>
            bookerBloc.type == 'hotel' ?
                bookerBloc.listBookings.isEmpty ?
                Center(
                  child: Text(
                    'No hotel booking for you',
                    style: GoogleFonts.raleway(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54
                    ),
                  ),
                ) :
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 70),
                  itemCount: bookerBloc.listBookings.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: bookerBloc,
                        ),
                        BlocProvider<HotelBookingItemBloc>(
                        create: (context) => HotelBookingItemBloc()..add(
                        HotelBookingItemInitialEvent(dateBooking: bookerBloc.listBookings[index],index: index)),),
                      ],
                        child: HotelCheckBookingItem());
                  },
                ):
                bookerBloc.listBookings.isEmpty ?
                Center(
                  child: Text(
                    'No vehicle booking for you',
                    style: GoogleFonts.raleway(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54
                    ),
                  ),
                ) :
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                  itemCount: bookerBloc.listBookings.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: bookerBloc,
                        ),
                        BlocProvider<VehicleBookingItemBloc>(
                        create: (context) => VehicleBookingItemBloc()..add(
                        VehicleBookingItemInitialEvent(dateBooking: bookerBloc.listBookings[index],index: index)),),
                      ],
                        child: VehicleCheckBookingItem());
                  },
                ),
            ),
          ),
        )
      );
  }
}