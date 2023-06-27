import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:get_it/get_it.dart';

import '../../../data/model/user.dart';
import '../../../data/repositories/user_repo.dart';


part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileInfoState> {
  User? user;
  File? image;
  EditProfileBloc(BuildContext context) : super(EditProfileInfoState(isPassWordVisible: false,
      isPassWordConfirmVisible: false, formKey: GlobalKey<FormState>(), updateSuccess: EditProfileStatus.initial)) {
    on<CheckPasswordVisibilityEvent>((event, emit) => emit(
        EditProfileInfoState(
            isPassWordVisible: !state.isPassWordVisible,
            isPassWordConfirmVisible: state.isPassWordConfirmVisible,
            formKey: state.formKey,)));

    on<CheckPasswordConfirmVisibilityEvent>((event, emit) => emit(
        EditProfileInfoState(
            isPassWordVisible: state.isPassWordVisible,
            isPassWordConfirmVisible: !state.isPassWordConfirmVisible,
            formKey: state.formKey,)));

    on<CheckInformationEvent>((event, emit) => emit(
        EditProfileInfoState(
            formKey: state.formKey,)));

    on<EditProfileEventSubmit>((event, emit) async {
        var userRepo = GetIt.instance.get<UserRepository>();
        try{
          bool updateState = await userRepo.updateUser(
              event.Username as String,
              event.Email as String,
              event.FirstName as String,
              event.LastName as String,
              event.Phone as String,
              event.Address as String,
              event.Gender as int);
          if(updateState) {
            print("Update success");
            emit(EditProfileInfoState(formKey: state.formKey, updateSuccess: EditProfileStatus.success));
            emit(EditProfileInfoState(formKey: state.formKey, updateSuccess: EditProfileStatus.initial));
          }
        }
        catch(e){
          print(e);
          emit(EditProfileInfoState(formKey: state.formKey, updateSuccess: EditProfileStatus.failure));
        }
    });

    on<EditProfileEventSubmitPassword>((event, emit) async {
      var userRepo = GetIt.instance.get<UserRepository>();
      try{
        bool updateState = await userRepo.changePassWord(event.Password as String);
        if(updateState) {
          print("Update success");
          emit(EditProfileInfoState(formKey: state.formKey, updateSuccess: EditProfileStatus.success));
          emit(EditProfileInfoState(formKey: state.formKey, updateSuccess: EditProfileStatus.initial));
        }
      }
      catch(e){
        print(e);
        emit(EditProfileInfoState(formKey: state.formKey, updateSuccess: EditProfileStatus.failure));
      }
    });

    on<EditProfileEventgetAvatarFromCamera>((event, emit) async {
      var userRepo = GetIt.instance.get<UserRepository>();
      try{
        image = await pickImageFromCamera();
        bool updateImageState = await userRepo.updateAvatar(image!);
        if(image != null && updateImageState) {
          print("Get and update image success");
          emit(EditProfileInfoState(formKey: state.formKey, getImageSuccess: EditProfileStatus.success));
          emit(EditProfileInfoState(formKey: state.formKey, getImageSuccess: EditProfileStatus.initial));
        }
      }
      catch(e){
        print(e);
        emit(EditProfileInfoState(formKey: state.formKey, getImageSuccess: EditProfileStatus.failure));
      }
    });

    on<EditProfileEventgetAvatarFromGallery>((event, emit) async {
      var userRepo = GetIt.instance.get<UserRepository>();

      try{
        image = await pickImageFromGallery();
        bool updateImageState = await userRepo.updateAvatar(image!);
        if(image != null && updateImageState) {
          print("Get and update image success");
          emit(EditProfileInfoState(formKey: state.formKey, getImageSuccess: EditProfileStatus.success));
          emit(EditProfileInfoState(formKey: state.formKey, getImageSuccess: EditProfileStatus.initial));
        }
      }
      catch(e){
        print(e);
        emit(EditProfileInfoState(formKey: state.formKey, getImageSuccess: EditProfileStatus.failure));
      }
    });

  }
  Future<File?> pickImageFromGallery() async {
    try{
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          image = File(pickedFile.path);
          return image;
        } else {
          print('No image selected.');
          return null;
        }
    } on PlatformException catch(e){
      print("Failed to pick image: $e");
    }
  }

  Future<File?> pickImageFromCamera() async {
    try{
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
        if (pickedFile != null) {
          image = File(pickedFile.path);
          return image;
        } else {
          print('No image selected.');
          return null;
        }
    } on PlatformException catch(e){
      print("Failed to pick image: $e");
    }
  }
}