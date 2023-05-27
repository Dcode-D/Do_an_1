import 'package:doan1/BLOC/profile/edit_profile/edit_profile_bloc.dart';
import 'package:doan1/widgets/dialog/add_social_link_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/model/user.dart';

class EditProfileScreen extends StatelessWidget{
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {

    Function addSocial = () {
      SmartDialog.showToast("Social link added!");
    };
    var bloc = context.read<EditProfileBloc>();
    bloc.add(getProfileEvent());

    return Scaffold(
      body: BlocBuilder<EditProfileBloc,EditProfileState>(
        builder: (context,state) =>
                  bloc.user !=null?
              NestedScrollView(
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
                          SmartDialog.show(builder: (context){
                            return Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width*0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Text(
                                    'Are you sure to save your\ninformation?',
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.red,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: TextButton(
                                          onPressed: (){
                                            SmartDialog.dismiss();
                                          },
                                          child: Text(
                                            'No',
                                            style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.green,
                                            boxShadow: [
                                          BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: TextButton(
                                          onPressed: (){
                                            SmartDialog.dismiss();
                                          },
                                          child: Text(
                                            'Yes',
                                            style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
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
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'First Name',
                                    ),
                                    keyboardType: TextInputType.name,
                                    initialValue: context.read<EditProfileBloc>().user?.firstname ?? "",
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
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Last Name',
                                      ),
                                      keyboardType: TextInputType.name,
                                      initialValue: context.read<EditProfileBloc>().user?.lastname ?? "",
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
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Address',
                                    ),
                                    keyboardType: TextInputType.streetAddress,
                                    initialValue: context.read<EditProfileBloc>().user?.address ?? "",
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
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Email',
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    initialValue: context.read<EditProfileBloc>().user?.email ?? "",
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
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Phone Number',
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    initialValue: context.read<EditProfileBloc>().user?.phonenumber ?? "",
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
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Username',
                                    ),
                                    keyboardType: TextInputType.number,
                                    initialValue: context.read<EditProfileBloc>().user?.username ?? "",
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
                                "Upload files",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Raleway',
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