import 'package:dio/dio.dart';
import 'package:doan1/BLOC/profile/edit_tour/edit_tour_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../BLOC/screen/all_screen/all_hotel/all_hotel_bloc.dart';

class AddEditHotelDialog extends StatefulWidget {
  @override
  _AddEditHotelDialogState createState() => _AddEditHotelDialogState();
}

class _AddEditHotelDialogState extends State<AddEditHotelDialog> {
  int page = 1;
  @override
  Widget build(BuildContext context) {
    var scrollController = ScrollController();
    var search = TextEditingController();
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        page++;
        context.read<AllHotelBloc>().add(GetHotelListExtraEvent(page: page));
      }
    });
    search.addListener(() {
      context.read<AllHotelBloc>().add(GetHotelByQuery(search.text));
    });
    var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close)),
                Text(
                  "Plan",
                  style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                    )),
              ],
            ),
            //search
            TextField(
                controller: search,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                    hintText: "Search...")),
            BlocBuilder<AllHotelBloc, AllHotelState>(
              builder: (context, state) {
                return state.getListHotelSuccess == true ?
                Expanded(
                  child: ListView.builder(
                    addAutomaticKeepAlives: true,
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    itemCount:
                    context.read<AllHotelBloc>().listHotel!.length,
                    itemBuilder: (context, index) {
                      return BlocBuilder<EditTourBloc, EditTourState>(
                        builder: (context, state) {
                          return CheckboxListTile(
                            title: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 100,
                                  height: 120,
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    child: FadeInImage(
                                      imageErrorBuilder:
                                          (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                                      image: NetworkImage(context
                                          .read<AllHotelBloc>()
                                          .listHotel !=
                                          null
                                          ? '$baseUrl/files/${context.read<AllHotelBloc>().listHotel![index].images![0]}'
                                          : ""),
                                      placeholder: const AssetImage(
                                          'assets/images/loading.gif'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          context.read<AllHotelBloc>().listHotel![index].name == null ?
                                          'No title'
                                              :
                                          context.read<AllHotelBloc>().listHotel![index].name!,
                                          style: GoogleFonts.raleway(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          context.read<AllHotelBloc>().listHotel![index].province == null &&
                                              context.read<AllHotelBloc>().listHotel![index].city == null
                                              ? 'No address'
                                              :
                                          '${context.read<AllHotelBloc>().listHotel![index].province}, ${context.read<AllHotelBloc>().listHotel![index].city}',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.raleway(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          context.read<AllHotelBloc>().listHotel![index].description == null ?
                                          'No description'
                                              :
                                          context.read<AllHotelBloc>().listHotel![index].description!,
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.raleway(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                            value: context.read<EditTourBloc>().listSelectedTourPlan.map((e) => e.id).contains(context.read<AllHotelBloc>().listHotel![index].id),
                            onChanged: (value) {
                              if (value!) {
                                context.read<EditTourBloc>().add(
                                    SetEditHotelPlan(tourHotel: [
                                      context.read<AllHotelBloc>().listHotel![index]]));
                              } else {
                                context.read<EditTourBloc>().add(
                                    RemoveEditHotelPlan(hotel: context.read<AllHotelBloc>().listHotel![index]));
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                )
                    : const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}

