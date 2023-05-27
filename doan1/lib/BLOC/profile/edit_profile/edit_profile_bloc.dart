import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meta/meta.dart';
import 'package:get_it/get_it.dart';

import '../../../data/model/user.dart';
import '../../../data/repositories/user_repo.dart';


part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  User? user = null;
  EditProfileBloc(BuildContext context) : super(EditProfileState(isPassWordVisible: false, isPassWordConfirmVisible: false, getUserSuccess: false)) {
    on<CheckPasswordVisibilityEvent>((event, emit) => emit(
        EditProfileState(
            isPassWordVisible: event.isPassWordVisible,
            isPassWordConfirmVisible: state.isPassWordConfirmVisible,
            getUserSuccess: state.getUserSuccess)));

    on<CheckPasswordConfirmVisibilityEvent>((event, emit) => emit(
        EditProfileState(
            isPassWordVisible: state.isPassWordVisible,
            isPassWordConfirmVisible: event.isPassWordConfirmVisible,
            getUserSuccess: state.getUserSuccess)));

    on <getProfileEvent>((event, emit) async {
      user = await getUser();
      if (user != null) {
        emit(EditProfileState(
            isPassWordVisible: state.isPassWordVisible,
            isPassWordConfirmVisible: state.isPassWordConfirmVisible,
            getUserSuccess: true));
      }
    });
  }
  Future<User?> getUser() async {
    var userRepo = GetIt.instance.get<UserRepo>();
    try {
      user = await userRepo.getUser();
      print("User:" + user!.email);
      return user;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}