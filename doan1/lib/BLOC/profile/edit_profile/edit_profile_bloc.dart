import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meta/meta.dart';
import 'package:get_it/get_it.dart';

import '../../../data/model/user.dart';
import '../../../data/repositories/user_repo.dart';


part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  User? user = null;
  EditProfileBloc(BuildContext context) : super(EditProfileState(isPassWordVisible: false,
      isPassWordConfirmVisible: false, formKey: GlobalKey<FormState>(), updateSuccess: false)) {
    on<CheckPasswordVisibilityEvent>((event, emit) => emit(
        EditProfileState(
            isPassWordVisible: event.isPassWordVisible,
            isPassWordConfirmVisible: state.isPassWordConfirmVisible,
            formKey: state.formKey,
            updateSuccess: state.updateSuccess)));

    on<CheckPasswordConfirmVisibilityEvent>((event, emit) => emit(
        EditProfileState(
            isPassWordVisible: state.isPassWordVisible,
            isPassWordConfirmVisible: event.isPassWordConfirmVisible,
            formKey: state.formKey,
            updateSuccess: state.updateSuccess)));
    on<CheckInformationEvent>((event, emit) => emit(
        EditProfileState(
            isPassWordVisible: state.isPassWordVisible,
            isPassWordConfirmVisible: state.isPassWordConfirmVisible,
            formKey: event.formKey,
            updateSuccess: state.updateSuccess)));
    on<EditProfileEventSubmit>((event, emit) async {
        var userRepo = GetIt.instance.get<UserRepo>();
        try{
          bool updateState = await userRepo.updateUser(
              event.Username as String,
              event.Password as String,
              event.Email as String,
              event.FirstName as String,
              event.LastName as String,
              event.Phone as String,
              event.Address as String,
              event.Gender as int);
          if(updateState) {
            print("Update success");
            emit(EditProfileState(isPassWordVisible: state.isPassWordVisible,
                isPassWordConfirmVisible: state.isPassWordConfirmVisible,
                formKey: state.formKey, updateSuccess: true));
          }
        }
        catch(e){
          print(e);
        }
    });
  }

}