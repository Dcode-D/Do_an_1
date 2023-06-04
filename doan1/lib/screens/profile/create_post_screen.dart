import 'dart:io';

import 'package:doan1/BLOC/profile/profile_view/profile_bloc.dart';
import 'package:doan1/models/destination_model.dart';
import 'package:doan1/widgets/dialog/add_avatar_image_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BLOC/posts/posts_bloc.dart';

class CreatePostScreen extends StatefulWidget{
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen>{
  final List<String> PostTypes = [
    'Destination',
    'Tour',
  ];

  String selectedValue = 'Destination';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostsBloc>(
          create: (BuildContext context) => PostsBloc(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
          return Scaffold(
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
                'Create Post',
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
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage("assets/images/avatar-wallpaper.jpg"),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nguyen Huy Tri Dung',
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.44,
                              height: 48,
                              child: DropdownButtonFormField2(
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                isExpanded: true,
                                hint: const Text(
                                  'Select type of post',
                                  style: TextStyle(fontSize: 14),
                                ),
                                value: selectedValue,
                                items: PostTypes
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                                    .toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select type of post';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value.toString();
                                  });
                                },
                                onSaved: (value) {
                                  selectedValue = value.toString();
                                },
                                buttonStyleData: const ButtonStyleData(
                                  height: 30,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black45,
                                  ),
                                  iconSize: 30,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_)=>
                                Center(
                                  child: ImagePickingDialog(getImageFromGallery: (){
                                    context.read<PostsBloc>().add(AddImageEvent(ImagePickMethod.gallery));
                                  }, getImageFromCamera: (){
                                    context.read<PostsBloc>().add(AddImageEvent(ImagePickMethod.camera));
                                  }, title: "Add image to the post"),
                                )
                            );
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    //FOR TOUR TODO: (Not include TourPlan)
                    const SizedBox(height: 10,),
                    selectedValue == 'Tour' ? Column(
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
                        Text(
                          'Plan',
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        //TODO: add list of destination
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
                    ) : Container(),
                    //FOR DESTINATION
                    selectedValue == 'Destination' ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Destination name',
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
                            hintText: 'Destination name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter destination name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10,),
                        //image selected list
                        SizedBox(
                          height: 200,
                          child: BlocBuilder<PostsBloc, PostsState>(
                            buildWhen: (previous, current) {
                              return current is PostsImageState|| current is PostsInitial;
                            },
                                        builder: (context, state) {
                                          return
                                          state is PostsInitial?
                                          const Text("No image selected"):
                                           GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              crossAxisSpacing: 8.0,
                                              mainAxisSpacing: 8.0,
                                            ),
                                            itemCount: (state as PostsImageState).listImages.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Image.file(
                                                (state as PostsImageState).listImages[index],
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                      ],
                    ) : Container(),
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
        );
  },
);
    }
  ),
);
  }
}