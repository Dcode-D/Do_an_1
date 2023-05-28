import 'package:doan1/BLOC/profile/edit_profile/edit_profile_bloc.dart';
import 'package:doan1/widgets/dialog/add_avatar_image_dialog.dart';
import 'package:doan1/widgets/dialog/add_social_link_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/model/user.dart';
import '../../widgets/dialog/update_info_dialog.dart';

class EditProfileScreen extends StatelessWidget{
  final ScrollController _scrollController = ScrollController();



  User? user;
  EditProfileScreen({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController(text: user!.email);
    final _firstnameController = TextEditingController(text: user!.firstname);
    final _lastnameController = TextEditingController(text: user!.lastname);
    final _addressController = TextEditingController(text: user!.address);
    final _usernameController = TextEditingController(text: user!.username);
    final _passwordController = TextEditingController();
    final _passwordConfirmController = TextEditingController();
    final _phoneController = TextEditingController(text: user!.phonenumber);
    addSocial() {
      SmartDialog.showToast("Social link added!");
    }

    return Scaffold(
      body: BlocBuilder<EditProfileBloc,EditProfileState>(
        builder: (context,state) =>
                  user != null ?
              Form(
                key:context.read<EditProfileBloc>().state.formKey,
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
                              context.read<EditProfileBloc>().add(CheckInformationEvent(formKey: context.read<EditProfileBloc>().state.formKey));
                              SmartDialog.show(builder: (context){
                                return UpdateInfoDialog();
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
                                child: Image.asset(
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
                                    SmartDialog.show(builder: (context){
                                      return AddAvatarDialog();
                                    });
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
                                      controller: _firstnameController,
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
                                        controller: _lastnameController,
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
                                      controller: _addressController,
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
                                      controller: _emailController,
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
                                      controller: _phoneController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your phone number';
                                        }
                                        else if(value!.isNotEmpty && value.length < 10 )
                                          return 'Please enter a valid phone number';
                                        else if(value!.isNotEmpty && value.length > 10 )
                                          return 'Please enter a valid phone number';
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
                                const Text(
                                  "Not Linked",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Raleway',
                                    color: Colors.black,),
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
                                      controller: _usernameController,
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
                            Row(
                                children:[
                                  const Icon(
                                    FontAwesomeIcons.lock,
                                    color: Colors.black,
                                    size: 20,
                                  ), const SizedBox(width: 20),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _passwordController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        else if (value.length < 8) {
                                          return 'Password must be at least 8 characters long.';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Password',
                                        suffixIcon: IconButton(
                                            icon: Icon(
                                              state.isPassWordVisible
                                                  ? FontAwesomeIcons.eye
                                                  : FontAwesomeIcons.eyeSlash,
                                              size: 20,
                                              color: Colors.black54,
                                            ),
                                            onPressed: () {
                                              context.read<EditProfileBloc>().
                                              add(CheckPasswordVisibilityEvent(isPassWordVisible: !state.isPassWordVisible));
                                            }
                                        ),
                                      ),
                                      keyboardType: TextInputType.visiblePassword,
                                      obscureText: !state.isPassWordVisible,
                                    ),
                                  ),
                                ]
                            ),
                            Row(
                                children:[
                                  const Icon(
                                    FontAwesomeIcons.lock,
                                    color: Colors.black,
                                    size: 20,
                                  ), const SizedBox(width: 20),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _passwordConfirmController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        else if (value.length < 8) {
                                          return 'Password must be at least 8 characters long.';
                                        }
                                        else if (value != _passwordController.text) {
                                          return 'Passwords do not match.';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Confirm Password',
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            state.isPassWordConfirmVisible
                                                ? FontAwesomeIcons.eye
                                                : FontAwesomeIcons.eyeSlash,
                                            size: 20,
                                            color: Colors.black54,
                                          ),
                                          onPressed: () {
                                            context.read<EditProfileBloc>().
                                            add(CheckPasswordConfirmVisibilityEvent(isPassWordConfirmVisible: !state.isPassWordConfirmVisible));
                                          }
                                        ),
                                      ),
                                      keyboardType: TextInputType.visiblePassword,
                                      obscureText: !state.isPassWordConfirmVisible,
                                    ),
                                  ),
                                ]
                            ),
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
                            const Text(
                              "Not Linked",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Rale way',
                                color: Colors.black,),
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
                                  "Upload files",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Rale way',
                                    color: Colors.black,),
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
  }
  
}