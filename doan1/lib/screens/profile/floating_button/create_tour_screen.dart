import 'package:doan1/BLOC/profile/profile_view/profile_bloc.dart';
import 'package:doan1/screens/profile/floating_button/widget/tour/add_plan_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../BLOC/create_tour/create_tour_bloc.dart';
import '../../../BLOC/screen/all_screen/all_article/article_bloc.dart';

class CreateTourScreen extends StatefulWidget {
  const CreateTourScreen({Key? key}) : super(key: key);

  @override
  _CreateTourScreenState createState() => _CreateTourScreenState();
}

class _CreateTourScreenState extends State<CreateTourScreen> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var articleBloc = context.read<ArticleBloc>();
    var createTourBloc = context.read<CreateTourBloc>();
    return BlocBuilder<ProfileBloc,ProfileState>(
      builder: (context,state) =>
          Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                'Create Tour',
                style: GoogleFonts.raleway(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  color: Colors.black,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: IconButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }
                  },
                  icon: const Icon(
                    FontAwesomeIcons.paperPlane,
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),
          //heading with avatar and camera icon
          body:Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: Colors.orange,
                                width: 2,
                              ),
                            ),
                            child: context.read<ProfileBloc>().image !=
                                null
                                ? ClipRRect(
                              borderRadius:
                              BorderRadius.circular(50),
                              child: Image.network(
                                context
                                    .read<ProfileBloc>()
                                    .image!,
                                fit: BoxFit.cover,
                              ),
                            )
                                : const CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage(
                                  "assets/images/undefine-wallpaper.jpg"),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Text(
                          context.read<ProfileBloc>().user?.firstname != null &&
                              context.read<ProfileBloc>().user?.lastname != null ?
                          "${context.read<ProfileBloc>().user!.firstname} ${context.read<ProfileBloc>().user!.lastname}"
                              : "Firstname Lastname",
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            // showDialog(
                            //     context: context,
                            //     builder: (_)=>
                            //         Center(
                            //           child: ImagePickingDialog(getImageFromGallery: (){
                            //             context.read<PostsBloc>().add(AddImageEvent(ImagePickMethod.gallery));
                            //           }, getImageFromCamera: (){
                            //             context.read<PostsBloc>().add(AddImageEvent(ImagePickMethod.camera));
                            //           }, title: "Add image to the post"),
                            //         )
                            // );
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tour name',
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Tour name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter tour name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Text(
                              'Plan',
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                showGeneralDialog(context: context,
                                    barrierDismissible: true,
                                    barrierLabel:
                                    MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                    barrierColor: Colors.black54,
                                    transitionDuration: const Duration(milliseconds: 400),
                                    transitionBuilder: (context, anim1, anim2, child) {
                                      return SlideTransition(
                                        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
                                        child: child,
                                      );
                                    },
                                    pageBuilder: (context,_,__){
                                      return BlocProvider<CreateTourBloc>.value(
                                          value: createTourBloc,
                                          child: AddPlanDialog(listArticle: articleBloc.listArticle,));
                                    });
                              },
                              child: Text(
                                'Add plan',
                                style: GoogleFonts.raleway(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.2,
                                  color: Colors.orange,
                                ),
                              )
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        BlocBuilder<CreateTourBloc,CreateTourState>(
                          builder: (context,state) =>
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.2),
                                  width:1
                              ),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 2),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: createTourBloc.listSelectedTourPlan.isEmpty ?
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Text(
                                'No plan added',
                                style: GoogleFonts.raleway(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.2,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ) :
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: createTourBloc.listSelectedTourPlan.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${createTourBloc.listSelectedTourPlan[index].title}',
                                            style: GoogleFonts.raleway(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.2,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              context.read<CreateTourBloc>().removeTourPlan(index);
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                )
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          'Price',
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Price',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter price';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      onTapOutside: (value) {
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                        hintText: 'Description',
                        hintStyle: GoogleFonts.raleway(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                          color: Colors.black45,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your post';
                        }
                        return null;
                      },
                      maxLines: 10,
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}