import 'package:doan1/BLOC/screen/all_screen/all_hotel/all_hotel_bloc.dart';
import 'package:doan1/BLOC/screen/book_history/book_history_bloc.dart';
import 'package:doan1/BLOC/widget_item/hotel_item/hotel_item_bloc.dart';
import 'package:doan1/screens/all/all_widget/hotel_item_for_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BLOC/profile/profile_view/profile_bloc.dart';
import '../../data/model/hotel.dart';

class AllHotelScreen extends StatelessWidget{
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var allHotelBloc = context.read<AllHotelBloc>();
    var profileBloc = context.read<ProfileBloc>();
    var bookHistoryBloc = context.read<BookHistoryBloc>();
    int page = 1;

    scrollController.addListener((){
      if (allHotelBloc.state.isLoadingMore == true && scrollController.position.pixels == scrollController.position.maxScrollExtent){
        return;
      }
      else
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        page=page+1;
        allHotelBloc.add(GetHotelListExtraEvent(page: page));
      }
    });
    
    return BlocListener<AllHotelBloc,AllHotelState>(
      listener: (context,state){
        if(state.maxData == true){
          SmartDialog.showToast('No more data', displayTime: const Duration(milliseconds: 1000));
        }
      },
      child: BlocBuilder<AllHotelBloc,AllHotelState>(
        bloc: allHotelBloc,
        builder:(context,state) =>
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ),
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Colors.white,
                centerTitle: true,
                title: Text(
                  'Hotels for you',
                  style: GoogleFonts.raleway(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600
                  )
                ),
              ),
            body: state.getListHotelSuccess == true?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                  child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  itemCount: state.isLoadingMore ? allHotelBloc.listHotel!.length + 1 : allHotelBloc.listHotel!.length,
                  itemBuilder: (BuildContext context, int index){
                    if(index < allHotelBloc.listHotel!.length){
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider<ProfileBloc>.value(value: profileBloc),
                          BlocProvider<BookHistoryBloc>.value(value: bookHistoryBloc),
                        ],
                        child: BlocProvider<HotelItemBloc>(
                            create: (context)=> HotelItemBloc()..add(GetHotelItemEvent(hotelId: allHotelBloc.listHotel![index].id)),
                            child: HotelItemForAll(type: 1,)),
                      );
                    }
                    else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  }
              ),
            ) :
            const Center(child: CircularProgressIndicator(),)
          ),
        ),
      ),
    );
  }
}