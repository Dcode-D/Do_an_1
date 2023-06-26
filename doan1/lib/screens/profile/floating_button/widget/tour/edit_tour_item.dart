import 'package:doan1/screens/profile/floating_button/widget/tour/edit_tour_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../BLOC/profile/edit_tour/edit_tour_bloc.dart';
import '../../../../../BLOC/profile/manage_news/manage_news_bloc.dart';
import '../../../../../BLOC/profile/profile_view/profile_bloc.dart';

class EditTourItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var profileBloc = context.read<ProfileBloc>();
    var editTourBloc = context.read<EditTourBloc>();
    var manageNewsBloc = context.read<ManageNewsBloc>();

    var formatCurrency = NumberFormat("#,###");

    deleteTour()=>{
      editTourBloc.add(DeleteTourEvent(tourID: editTourBloc.tour!.id!)),
      manageNewsBloc.add(DeleteTour(tourIndex: editTourBloc.index!)),
    };

    return BlocBuilder<EditTourBloc,EditTourState>(
      builder: (context,state) => Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 5,
              ),],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.flag, size: 25,
                    ),
                    const SizedBox(width: 10,),
                    Text('Tour',
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.bold),),
                    // const Spacer(),
                    // Text('12/12/2021',
                    //   style: GoogleFonts.roboto(
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.bold),),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    editTourBloc.tour != null ?
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: FadeInImage(
                        width: MediaQuery.of(context).size.width * 0.325,
                        height: MediaQuery.of(context).size.height * 0.15,
                        imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                        image:
                        NetworkImage(editTourBloc.tour!=null && editTourBloc.images!.isNotEmpty ? editTourBloc.images![0]: ""),
                        placeholder: const AssetImage('assets/images/loading.gif'),
                        fit: BoxFit.cover,
                      ),
                    )
                        :
                    const Center(child: CircularProgressIndicator()),
                    const SizedBox(width: 10,),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(editTourBloc.tour != null ? editTourBloc.tour!.name! : "",
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.bold),),
                          const SizedBox(height: 5,),
                          Text(editTourBloc.tour != null ?
                          editTourBloc.tour!.maxGroupSize! > 1 ?
                          "Tour for: ${editTourBloc.tour!.maxGroupSize!.toStringAsFixed(0)} people" :
                          "Tour for: ${editTourBloc.tour!.maxGroupSize!.toStringAsFixed(0)} person" : "",
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.w400),),
                          const SizedBox(height: 5,),
                          Text(editTourBloc.tour != null ? editTourBloc.tour!.description! : "",
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.w400),),

                        ],),
                    )
                  ],
                ),
                const SizedBox(height: 10,),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black12,
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Text(
                      editTourBloc.tour != null ? "Price: ${formatCurrency.format(editTourBloc.tour!.price!)} VNĐ" : "",
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider.value(value: profileBloc),
                                  BlocProvider.value(value: editTourBloc..add(RefreshTourInfo())),
                                  BlocProvider.value(value: manageNewsBloc),
                                ],
                                child: EditTourScreen()),
                          ),
                        );
                      },
                      child:
                      const Text(
                        'Detail',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        ),),
                    ),
                    const SizedBox(width: 10,),
                    ElevatedButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Tour'),
                              content: const Text('Are you sure you want to delete this tour?'),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: (){
                                    deleteTour();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            )
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      child:
                      Text(
                        'Delete',
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        ),),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}