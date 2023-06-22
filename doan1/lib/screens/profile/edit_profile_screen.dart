import 'package:doan1/BLOC/profile/edit_profile/edit_profile_bloc.dart';
import 'package:doan1/BLOC/profile/profile_view/profile_bloc.dart';
import 'package:doan1/widgets/dialog/add_avatar_image_dialog.dart';
import 'package:doan1/widgets/dialog/add_social_link_dialog.dart';
import 'package:doan1/widgets/dialog/change_password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/dialog/update_info_dialog.dart';

class EditProfileScreen extends StatefulWidget{
  EditProfileScreen({Key? key}) : super(key: key);
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>{
  final ScrollController _scrollController = ScrollController();

  _EditProfileScreenState({Key? key}) : super();
  @override
  Widget build(BuildContext context) {

    ProfileBloc profileBloc = context.read<ProfileBloc>();

    final emailController = TextEditingController(text: profileBloc.user?.email);
    final firstnameController = TextEditingController(text: profileBloc.user?.firstname);
    final lastnameController = TextEditingController(text: profileBloc.user?.lastname);
    final addressController = TextEditingController(text: profileBloc.user?.address);
    final usernameController = TextEditingController(text: profileBloc.user?.username);
    final phoneController = TextEditingController(text: profileBloc.user?.phonenumber);

    addSocial() {
      SmartDialog.showToast("Social link added!");
    }

    var bloc = BlocProvider.of<EditProfileBloc>(context);

    pickImageFromCamera(){
      bloc.add(EditProfileEventgetAvatarFromCamera());
    }

    pickImageFromGallery(){
      bloc.add(EditProfileEventgetAvatarFromGallery());
    }

    updateProfile(){
      bloc.add(EditProfileEventSubmit(
          FirstName: firstnameController.text,
          LastName: lastnameController.text,
          Email: emailController.text,
          Address: addressController.text,
          Username: usernameController.text,
          Phone: phoneController.text,
          Gender: profileBloc.user!.gender,
      ));
    }

    return SafeArea(
      child: Scaffold(
        body:
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
          return BlocListener<EditProfileBloc,EditProfileInfoState>(
          bloc: bloc,
          listener: (context,state){
            if(state.updateSuccess == EditProfileStatus.success){
              SmartDialog.showToast("Update success!");
              Navigator.pop(context);
            }
            if(state.updateSuccess == EditProfileStatus.failure){
              SmartDialog.showToast("Update failed!");
            }
            if(state.getImageSuccess == EditProfileStatus.success){
              profileBloc.add(getProfileScreenEvent());
            }
          },
          child: BlocBuilder<EditProfileBloc,EditProfileInfoState>(
            builder: (context,state) =>
            profileBloc.user != null ?
                  Form(
                    key:state.formKey,
                    child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder: (context,value){
                      return [
                      SliverAppBar(
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
                        centerTitle: true,
                        floating: true,
                        pinned: true,
                        snap: true,
                        backgroundColor: Colors.white,
                        title: Text(
                          'Personal Information',
                          style: GoogleFonts.raleway(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,)
                        ),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: IconButton(
                              onPressed: (){
                                if (context.read<EditProfileBloc>().state.formKey.currentState!.validate()) {
                                  showDialog(context: context,
                                      builder: (_){
                                      return Center(
                                        child: UpdateInfoDialog(
                                          updateProfileSubmit: updateProfile,
                                      ),
                                      );
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      )
                    ];
                },
                    body: SingleChildScrollView(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Stack(
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: profileBloc.image != null ?
                                    Image.network(profileBloc.image!,fit: BoxFit.cover,)
                                        :
                                    Image.asset(
                                      'assets/images/avatar-wallpaper.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black.withOpacity(0.3),
                                      ),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return Center(
                                              child: ImagePickingDialog(
                                                title: 'Please add your best avatar image',
                                                getImageFromCamera: pickImageFromCamera,
                                                getImageFromGallery: pickImageFromGallery,),
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.3),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                            child: Column(
                              children:[
                                Row(
                                  children:[
                                    const Icon(
                                      FontAwesomeIcons.user,
                                      color: Colors.black,
                                      size: 20,
                                    ), const SizedBox(width: 20),
                                    Expanded(
                                      child: BlocBuilder<EditProfileBloc,EditProfileState>(
                                        builder: (context,state) => TextFormField(
                                          controller: firstnameController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your first name';
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'First Name',
                                          ),
                                          keyboardType: TextInputType.name,
                                        ),
                                      ),
                                    ),
                                  ]
                                ),
                                Row(
                                    children:[
                                      const Icon(
                                        FontAwesomeIcons.user,
                                        color: Colors.black,
                                        size: 20,
                                      ), const SizedBox(width: 20),
                                      Expanded(
                                        child: BlocBuilder<EditProfileBloc,EditProfileState>(
                                          builder: (context,state) => TextFormField(
                                            controller: lastnameController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter your last name';
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'Last Name',
                                            ),
                                            keyboardType: TextInputType.name,
                                          ),
                                        ),
                                      ),
                                    ]
                                ),
                                Row(
                                    children:[
                                      const Icon(
                                        FontAwesomeIcons.mapMarkerAlt,
                                        color: Colors.black,
                                        size: 20,
                                      ), const SizedBox(width: 20),
                                      Expanded(
                                        child: TextFormField(
                                          controller: addressController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your address';
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'Address',
                                          ),
                                          keyboardType: TextInputType.streetAddress,
                                        ),
                                      ),
                                    ]
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                   Image.asset(
                                     'assets/icons/icon-gender.png',
                                      width: 30,
                                      height: 30,
                                   ),
                                   const SizedBox(width: 10),
                                   Text(
                                     ChangeGenderValue(profileBloc.user!.gender),
                                     style: GoogleFonts.raleway(
                                       fontSize: 16,
                                       fontWeight: FontWeight.w400,
                                       color: Colors.black,
                                     ),
                                   )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: Container(
                                    height: 1.5,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                    children:[
                                      const Icon(
                                        FontAwesomeIcons.birthdayCake,
                                        color: Colors.black,
                                        size: 20,
                                      ), const SizedBox(width: 20),
                                      Expanded(
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'Date of birth',
                                          ),
                                          keyboardType: TextInputType.datetime,
                                          initialValue: '15/10/2002',
                                        ),
                                      ),
                                    ]
                                )
                              ]
                            ),
              ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.3),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                    children:[
                                      const Icon(
                                        FontAwesomeIcons.envelope,
                                        color: Colors.black,
                                        size: 20,
                                      ), const SizedBox(width: 20),
                                      Expanded(
                                        child: TextFormField(
                                          controller: emailController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your email';
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'Email',
                                          ),
                                          keyboardType: TextInputType.emailAddress,
                                        ),
                                      ),
                                    ]
                                ),
                                Row(
                                    children:[
                                      const Icon(
                                        FontAwesomeIcons.phone,
                                        color: Colors.black,
                                        size: 20,
                                      ), const SizedBox(width: 20),
                                      Expanded(
                                        child: TextFormField(
                                          controller: phoneController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your phone number';
                                            }
                                            else if(value!.isNotEmpty && value.length < 10 ) {
                                              return 'Please enter a valid phone number';
                                            } else if(value!.isNotEmpty && value.length > 10 ) {
                                              return 'Please enter a valid phone number';
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'Phone Number',
                                          ),
                                          keyboardType: TextInputType.phone,
                                        ),
                                      ),
                                    ]
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.globe,
                                      color: Colors.black,
                                      size: 20,
                                    ), const SizedBox(width: 20),
                                    Text(
                                      "Not Linked",
                                      style: GoogleFonts.raleway(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const Spacer(),
                                    ElevatedButton(
                                        onPressed: (){
                                          showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext buildContext){
                                                return AddSocialDialog(addSocial: addSocial);
                                              });
                                        },
                                        child: const Text(
                                            "Add URL",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Raleway',
                                            color: Colors.black,),
                                        )
                                    ),
                                  ],
                                )
                              ]
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.3),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                    children:[
                                      const Icon(
                                        FontAwesomeIcons.user,
                                        color: Colors.black,
                                        size: 20,
                                      ), const SizedBox(width: 20),
                                      Expanded(
                                        child: TextFormField(
                                          controller: usernameController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your username';
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'Username',
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    ]
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.lock,
                                      color: Colors.black,
                                      size: 20,
                                    ), const SizedBox(width: 20),
                                    Text(
                                      'Password: *********',
                                      style: GoogleFonts.raleway(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const Spacer(),
                                    ElevatedButton(
                                        onPressed: (){
                                          showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (_){
                                                return BlocProvider.value(
                                                  value: BlocProvider.of<EditProfileBloc>(context),
                                                  child: Center(
                                                    child: ChangePassWordDialog(),
                                                  ),
                                                );
                                              });
                                        },
                                        child: const Text(
                                          "Change",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Raleway',
                                            color: Colors.black,),
                                        )
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:15),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.3),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                            child:
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.idCard,
                                  color: Colors.black,
                                  size: 20,
                                ), const SizedBox(width: 20),
                                Text(
                                  "Not Linked",
                                  style: GoogleFonts.raleway(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  )
                                ),
                                const Spacer(),
                                ElevatedButton(
                                    onPressed: (){
                                      showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext buildContext){
                                            return AddSocialDialog(addSocial: addSocial);
                                          });
                                    },
                                    child: Text(
                                      "Upload files",
                                      style: GoogleFonts.raleway(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ],
                      ),
                    )
              ),
                  ) :
                    const Center(
                      child: CircularProgressIndicator(
                      color: Colors.orange,
                      ),
                    ),
          ),
        );
  },
),
      ),
    );
  }
  String ChangeGenderValue(int? selectedValue){
    return selectedValue == 1 ? 'Male' : 'Female';
  }

}