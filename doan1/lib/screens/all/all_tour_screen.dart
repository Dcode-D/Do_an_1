import 'package:doan1/BLOC/widget_item/tour_item/tour_item_bloc.dart';
import 'package:doan1/screens/all/all_widget/tour_item_for_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BLOC/profile/profile_view/profile_bloc.dart';
import '../../BLOC/screen/all_screen/all_tour/all_tour_bloc.dart';

class AllTourScreen extends StatelessWidget {
  final PageController scrollController = PageController();
  @override
  Widget build(BuildContext context) {
    var profileBloc = context.read<ProfileBloc>();
    var allTourBloc = context.read<AllTourBloc>();
    var page=1;
    scrollController.addListener((){
      if (allTourBloc.state.isLoadingMore == true && scrollController.position.pixels == scrollController.position.maxScrollExtent){
        return;
      }
      else
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        page=page+1;
        allTourBloc.add(GetTourListExtraEvent(page: page));
      }
    });
    return SafeArea(
      child: BlocListener<AllTourBloc,AllTourState>(
        listener: (context,state){
          if(state.maxData == true){
            SmartDialog.showToast('No more data', displayTime: const Duration(milliseconds: 1000));
          }
        },
        child: BlocBuilder<AllTourBloc,AllTourState>(
          builder: (context,state) => Scaffold(
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
                'Tour of the week',
                style: GoogleFonts.raleway(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600
                )
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child:
                  allTourBloc.listTour != null ?
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  itemCount: state.isLoadingMore ? allTourBloc.listTour!.length + 1 : allTourBloc.listTour!.length,
                  itemBuilder: (BuildContext context, int index){
                    if(index < allTourBloc.listTour!.length){
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider<ProfileBloc>.value(value: profileBloc),
                        ],
                        child: BlocProvider<TourItemBloc>(
                            create: (context)=> TourItemBloc()..add(GetTourItemEvent(tourId: allTourBloc.listTour![index].id)),
                            child: TourItemForAll()),
                      );
                    }
                    else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  }) : const Center(child: CircularProgressIndicator(),),
            ),
          ),
        ),
      ),
    );
  }
}

