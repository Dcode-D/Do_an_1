import 'package:doan1/BLOC/profile/edit_post/edit_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../BLOC/components/places/places_bloc.dart';
import '../../../../../BLOC/news_create/posts/posts_bloc.dart';
import '../../../../../BLOC/profile/profile_view/profile_bloc.dart';
import '../../../../../widgets/dialog/add_avatar_image_dialog.dart';
import 'package:doan1/Utils/image_pick_method.dart' as ImgMethod;

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({Key? key}) : super(key: key);

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final desController = TextEditingController();
  final titleController = TextEditingController();
  final addressController = TextEditingController();
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final provinceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PostsBloc>(
            create: (BuildContext context) => PostsBloc(),
          ),
        ],
        child: BlocListener<EditPostBloc, EditPostState>(
            listenWhen: (previous, current) {
              return current is EditPostResultState || current is EditPostDataInitial;
            },
            listener: (context, state) {
              if (state is EditPostResultState) {
                if (state.editSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Edit post successfully'),
                    duration: Duration(seconds: 1),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Edit post failed'),
                    duration: Duration(seconds: 1),
                  ));
                }
              }
              if(state is EditPostDataInitial){
                if (context.read<EditPostBloc>().article != null) {
                  desController.text =
                  context.read<EditPostBloc>().article!.description!;
                  titleController.text =
                  context.read<EditPostBloc>().article!.title!;
                  addressController.text =
                      context.read<EditPostBloc>().article!.address ?? "";
                  nameController.text = context
                      .read<EditPostBloc>()
                      .article!
                      .referenceName!;
                  cityController.text =
                  context.read<EditPostBloc>().article!.city!;
                  provinceController.text =
                  context.read<EditPostBloc>().article!.province!;
                }
              }
            },
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
                    'Edit Post',
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
                          // _formKey.currentState!.save();
                          context.read<EditPostBloc>().add(EditPostEventUpdate(
                                title: titleController.text,
                                description: desController.text,
                                address: addressController.text,
                                name: nameController.text,
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
              body: Form(
                  key: _formKey,
                  child: BlocBuilder<EditPostBloc, EditPostState>(
                    buildWhen: (previous, current) {
                      if(current is EditPostDataInitial){
                        return true;
                      }
                      return false;
                    },
                    builder: (context, state) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                          context.read<ProfileBloc>().image !=
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
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      context
                                                      .read<ProfileBloc>()
                                                      .user
                                                      ?.firstname !=
                                                  null &&
                                              context
                                                      .read<ProfileBloc>()
                                                      .user
                                                      ?.lastname !=
                                                  null
                                          ? "${context.read<ProfileBloc>().user!.firstname} ${context.read<ProfileBloc>().user!.lastname}"
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
                                          context: context,
                                          builder: (_) => Center(
                                                child: ImagePickingDialog(
                                                    getImageFromGallery: () {
                                                      context
                                                          .read<EditPostBloc>()
                                                          .add(EditPostEventAddImage(
                                                              method: ImgMethod
                                                                  .ImagePickMethod
                                                                  .GALLERY));
                                                    },
                                                    getImageFromCamera: () {
                                                      context
                                                          .read<EditPostBloc>()
                                                          .add(EditPostEventAddImage(
                                                              method: ImgMethod
                                                                  .ImagePickMethod
                                                                  .CAMERA));
                                                    },
                                                    title:
                                                        "Add image to the post"),
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Please add some images of your hotel',
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: BlocBuilder<EditPostBloc,
                                            EditPostState>(
                                          builder: (context, state) {
                                            return (context
                                                            .read<
                                                                EditPostBloc>()
                                                            .images ==
                                                        null ||
                                                    context
                                                        .read<EditPostBloc>()
                                                        .images!
                                                        .isEmpty)
                                                ? const Text(
                                                    "No image selected")
                                                : GridView.builder(
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      crossAxisSpacing: 8.0,
                                                      mainAxisSpacing: 8.0,
                                                    ),
                                                    itemCount: context
                                                        .read<EditPostBloc>()
                                                        .images!
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return SizedBox(
                                                        width: 100,
                                                        height: 100,
                                                        child: Stack(
                                                          children: [
                                                            Image.network(
                                                              context
                                                                  .read<
                                                                      EditPostBloc>()
                                                                  .images![index],
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (BuildContext
                                                                      context,
                                                                  Object
                                                                      exception,
                                                                  StackTrace?
                                                                      stackTrace) {
                                                                return const Center(
                                                                  child: Icon(
                                                                    Icons.error,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                            Positioned(
                                                              top: -10,
                                                              right: -5,
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  context
                                                                      .read<
                                                                          EditPostBloc>()
                                                                      .add(EditPostEventDeleteImage(
                                                                          index:
                                                                              index));
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons.cancel,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Province",
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
                                    controller: provinceController,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: 'Province',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "City",
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
                                    enabled: false,
                                    controller: cityController,
                                    decoration: InputDecoration(
                                      hintText: 'City',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
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
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            )));
  }
}
