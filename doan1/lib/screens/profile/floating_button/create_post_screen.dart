
import 'package:doan1/BLOC/components/places/places_bloc.dart';
import 'package:doan1/BLOC/profile/profile_view/profile_bloc.dart';
import 'package:doan1/widgets/dialog/add_avatar_image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../BLOC/news_create/posts/posts_bloc.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  var provinceCode = -1;
  var provinceName = '';
  var districtCode = -1;
  var districtName = '';
  var wardCode = -1;
  var wardName = '';

  @override
  Widget build(BuildContext context) {
    final desController = TextEditingController();
    final titleController = TextEditingController();
    final addressController = TextEditingController();
    final nameController = TextEditingController();
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostsBloc>(
          create: (BuildContext context) =>
              PostsBloc(),
        ),
      ],
      child: Builder(builder: (context) {
        return BlocListener<PostsBloc, PostsState>(
          listenWhen: (previous, current) {
            if (current is PostCreatePostsState) {
              return true;
            }
            return false;
          },
          listener: (context, state) {
            if(state is PostCreatePostsState){
              if(state.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("Posted successfully!"),
                  ),
                );
                Navigator.pop(context);
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Something went wrong!"),
                  ),
                );
              }
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return SafeArea(
                child: Scaffold(
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
                                context.read<PostsBloc>().add(CreatePostEvent(
                                      title: titleController.text,
                                      description: desController.text,
                                      address: addressController.text,
                                      referenceName: nameController.text,
                                      province: provinceName,
                                      district: districtName,
                                    ));
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
                    body: Form(
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
                                      child:
                                          context.read<ProfileBloc>().image != null
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
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      context.read<ProfileBloc>().user?.firstname != null &&
                                          context.read<ProfileBloc>().user?.lastname != null ?
                                      "${context.read<ProfileBloc>().user!.firstname} ${context.read<ProfileBloc>().user!.lastname}"
                                          : "Firstname Lastname",
                                      style: GoogleFonts.raleway(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context, builder: (_) =>
                                          Center(
                                            child: ImagePickingDialog(getImageFromGallery: () {
                                              context.read<PostsBloc>().add(AddImageEvent(
                                                  ImagePickMethod.gallery));
                                              },
                                                getImageFromCamera: () {
                                              context.read<PostsBloc>()
                                                  .add(AddImageEvent(
                                                  ImagePickMethod.camera));
                                                    },
                                                title: "Add image to the post"),
                                          ));
                                    },
                                    icon: const Icon(
                                      Icons.add_a_photo,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Title',
                                    style: GoogleFonts.raleway(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: titleController,
                                    decoration: InputDecoration(
                                      hintText: 'Tile of the post',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the title';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Destination name',
                                    style: GoogleFonts.raleway(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: nameController,
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
                                  Text('Please add some images of your hotel',
                                    style: GoogleFonts.raleway(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic,
                                      letterSpacing: 1.2,
                                      color: Colors.orange,
                                    ),
                                  ),

                                  //image selected list
                                  SingleChildScrollView(
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.black.withOpacity(0.2),
                                        ),
                                      ),
                                      child: SizedBox(
                                        height: 200,
                                        width: MediaQuery.of(context).size.width,
                                        child: BlocBuilder<PostsBloc, PostsState>(
                                          buildWhen: (previous, current) {
                                            return current is PostsImageState ||
                                                current is PostsInitial;
                                          },
                                          builder: (context, state) {
                                            return state is PostsInitial ||
                                                    (state is PostsImageState &&
                                                        state.listImages.isEmpty) ?
                                            const Text("No image selected")
                                                :
                                            GridView.builder(
                                              gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 8.0,
                                                mainAxisSpacing: 8.0,
                                              ),
                                              itemCount: context.read<PostsBloc>().listImages.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                return Stack(
                                                  children:[
                                                    Image.file(
                                                      context.read<PostsBloc>().listImages[index],
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          context.read<PostsBloc>().add(RemoveImageEvent(index));},
                                                        icon: const Icon(
                                                          Icons.cancel,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );},
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  BlocProvider<PlacesBloc>(
                                    create: (context) => PlacesBloc()..add(GetProvinceEvent()),
                                  child:
                                  //Province List
                                  Column(
                                    children: [
                                      BlocBuilder<PlacesBloc, PlacesState>(
                                          buildWhen: (previous, current) {
                                        return current is PlaceProvinceState ||
                                            current is PlacesInitial;
                                          }, builder: (context, state) {
                                        return state is PlaceProvinceState ?
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Province',
                                              style: GoogleFonts.raleway(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 1.2,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 10,),
                                            DropdownButtonFormField<Map>(
                                              decoration: InputDecoration(
                                                hintText: 'Province',
                                                border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(5),
                                                ),
                                              ),
                                              items:
                                              (state as PlaceProvinceState).listProvince.map((item) =>
                                                  DropdownMenuItem<Map>(
                                                    value: item,
                                                    child: Text(
                                                      item['name'],
                                                      style:
                                                      const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  )).toList(),
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'Please select province';
                                                }
                                                return null;
                                                },
                                              onChanged: (value) {context.read<PlacesBloc>().add(
                                                  GetDistrictEvent(value?['code']));
                                                      provinceCode = value?['code'];
                                                      provinceName = value?['name'];
                                                    },
                                                    onSaved: (value) {
                                                      context.read<PlacesBloc>().add(
                                                          GetDistrictEvent(
                                                              value?['code']));
                                                      provinceCode = value?['code'];
                                                      provinceName = value?['name'];
                                                    },
                                                  ),
                                                ],
                                              )
                                            :
                                        const CircularProgressIndicator();
                                      }),
                                  //District List
                                  BlocBuilder<PlacesBloc, PlacesState>(
                                      buildWhen: (previous, current) {
                                    return current is PlaceDistrictState ||
                                        current is PlacesInitial;
                                  }, builder: (context, state) {
                                    return state is PlaceDistrictState
                                        ?
                                        //Real district list
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 10,),
                                              Text(
                                                'District',
                                                style: GoogleFonts.raleway(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 1.2,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              DropdownButtonFormField<Map>(
                                                decoration: InputDecoration(
                                                  hintText: 'District',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(5),
                                                  ),
                                                ),
                                                value: state.listDistrict[0],
                                                items: (state as PlaceDistrictState)
                                                    .listDistrict
                                                    .map((item) =>
                                                    DropdownMenuItem<Map>(
                                                      value: item,
                                                      child: Text(
                                                        item['name'],
                                                        style:
                                                        const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    )).toList(),
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Please select district';
                                                  }
                                                  return null;
                                                },
                                                onChanged: (value) {
                                                  districtCode = value?['code'];
                                                  districtName = value?['name'];
                                                },
                                                onSaved: (value) {
                                                  districtCode = value?['code'];
                                                  districtName = value?['name'];
                                                },
                                              ),
                                            ],
                                          )
                                        :
                                        //Place holder district list
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 10,),
                                            Text(
                                              'District',
                                              style: GoogleFonts.raleway(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 1.2,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            DropdownButtonFormField(
                                                items: const [],
                                                onChanged: (value) {},
                                                decoration: InputDecoration(
                                                hintText: 'District',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                  ),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Please select district';
                                                  }
                                                  return null;
                                                },
                                              ),
                                          ],
                                        );
                                  }),],
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Text(
                                    "Address",
                                    style: GoogleFonts.raleway(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //Address
                                  TextFormField(
                                    controller: addressController,
                                    decoration: InputDecoration(
                                      hintText: 'Address',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter address';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: desController,
                                onTapOutside: (value) {
                                  FocusScope.of(context).unfocus();
                                },
                                decoration: InputDecoration(
                                  hintText: 'Description',
                                  hintStyle: GoogleFonts.raleway(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1.2,
                                    color: Colors.black,
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
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
              );
            },
          ),
        );
      }),
    );
  }
}
