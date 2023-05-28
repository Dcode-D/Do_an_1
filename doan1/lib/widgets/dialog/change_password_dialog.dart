import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BLOC/profile/edit_profile/edit_profile_bloc.dart';

class ChangePassWordDialog extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ChangePassWordDialogState();
  }
}

class _ChangePassWordDialogState extends State<ChangePassWordDialog>{
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc,EditProfileInfoState>(
      builder: (context,state)
        => Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 310,
            width: MediaQuery.of(context).size.width*0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
          child:
          Column(
            children: [
              Text(
                'Change Password',
                textAlign: TextAlign.center,
                softWrap: true,
                style: GoogleFonts.raleway(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
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
                          border: const UnderlineInputBorder(),
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
                                add(CheckPasswordVisibilityEvent());
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
                          border: const UnderlineInputBorder(),
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
                                add(CheckPasswordConfirmVisibilityEvent());
                              }
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !state.isPassWordConfirmVisible,
                      ),
                    ),
                  ]
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
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
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
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {
                        formKey.currentState!.validate() ? {
                          context.read<EditProfileBloc>().add(
                              EditProfileEventSubmitPassword(
                                Password: _passwordController.text,
                              )
                          ),
                        } : null;
                      },
                      child: Text(
                        'Save',
                        style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      ),
                    ),
                ],
              ),
            ],
          )
      ),
        ),
    );
  }
}