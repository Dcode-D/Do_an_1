import 'dart:io';

import 'package:doan1/BLOC/profile/edit_profile/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickingDialog extends StatelessWidget{
  Function getImageFromGallery;
  Function getImageFromCamera;
  String title;

  ImagePickingDialog({required this.getImageFromGallery, required this.getImageFromCamera, required this.title});
  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 260,
        width: MediaQuery.of(context).size.width*0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                softWrap: true,
                style: GoogleFonts.raleway(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset('assets/icons/icon-photographer.png', width: 100, height: 100,),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange,
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
                        getImageFromCamera();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Capture photo',
                        style: GoogleFonts.raleway(
                          fontSize: 18,
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
                      color: Colors.orange,
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
                        getImageFromGallery();

                        Navigator.pop(context);
                      },
                      child: Text(
                        'Gallery',
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
          ),
        ),
    );
  }
}