import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meta/meta.dart';
import 'package:get_it/get_it.dart';

import '../../../data/model/user.dart';
import '../../../data/repositories/user_repo.dart';


part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileInfoState> {
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
        var userRepo = GetIt.instance.get<UserRepo>();
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
      var userRepo = GetIt.instance.get<UserRepo>();
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
  }

}