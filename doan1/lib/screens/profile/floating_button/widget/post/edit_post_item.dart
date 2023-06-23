import 'package:doan1/BLOC/profile/edit_post/edit_post_bloc.dart';
import 'package:doan1/BLOC/profile/manage_news/manage_news_bloc.dart';
import 'package:doan1/screens/profile/floating_button/widget/dialog/post_delete_dialog.dart';
import 'package:doan1/screens/profile/floating_button/widget/post/edit_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../BLOC/profile/profile_view/profile_bloc.dart';

class EditPostItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var editPostBloc = context.read<EditPostBloc>();
    var manageNewsBloc = context.read<ManageNewsBloc>();
    var profileBloc = context.read<ProfileBloc>();
    deletePost()=>{
      editPostBloc.add(DeletePostEvent(articleID: editPostBloc.article!.id!)),
      manageNewsBloc.add(DeleteNews(articleIndex: editPostBloc.index!)),
      Navigator.pop(context)
    };

    return BlocBuilder<EditPostBloc,EditPostState>(
      builder: (context,state)
      => Padding(
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
                      FontAwesomeIcons.locationArrow, size: 20,
                    ),
                    const SizedBox(width: 10,),
                    Text('Destination',
                      style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w600),),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    editPostBloc.article != null ?
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: FadeInImage(
                        width: MediaQuery.of(context).size.width * 0.325,
                        height: MediaQuery.of(context).size.height * 0.15,
                        imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                        image:
                        NetworkImage(editPostBloc.article!=null && editPostBloc.images!.isNotEmpty ? editPostBloc.images![0]: ""),
                        placeholder: const AssetImage('assets/images/loading.gif'),
                        fit: BoxFit.cover,
                      ),
                    )
                        :
                    const Center(child: CircularProgressIndicator()),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(editPostBloc.article!=null ? editPostBloc.article!.title! : "Loading...",
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.bold),),
                        const SizedBox(height: 5,),
                        Text(editPostBloc.article!=null ? '${editPostBloc.article!.province!}, ${editPostBloc.article!.city!}' : "Loading...",
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.w500),),
                        const SizedBox(height: 5,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(editPostBloc.article!=null ? editPostBloc.article!.description! : "Loading...",
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.w400),),
                        ),
                      ],)
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
                      editPostBloc.article != null ?
                          editPostBloc.article!.publishedDate != null ?
                      'Published Date: ${editPostBloc.article!.publishedDate!.day}/'
                          '${editPostBloc.article!.publishedDate!.month}/'
                          '${editPostBloc.article!.publishedDate!.year}' :
                      'Loading...' : 'Loading...',
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
                            MaterialPageRoute(builder: (context) =>
                            MultiBlocProvider(
                              providers: [
                                BlocProvider.value(value: editPostBloc..add(RefreshPostEvent())),
                                BlocProvider.value(value: manageNewsBloc),
                                BlocProvider.value(value: profileBloc,),
                                ],
                                child: const EditPostScreen()),
                            )
                        );
                      },
                      child:
                      Text(
                        'Detail',
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        ),),
                    ),
                    const SizedBox(width: 10,),
                    ElevatedButton(
                      onPressed: (){
                        showGeneralDialog(context: context,
                            pageBuilder: (context, anim1, anim2) => DeletePostDialog(deletePost: deletePost,));
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