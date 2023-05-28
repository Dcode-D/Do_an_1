import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/user.dart';
import '../../../data/repositories/user_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent,ProfileState>{
  User? user;
  ProfileBloc(BuildContext context): super(ProfileState(getUserSuccess: false)){
    on<getProfileScreenEvent>((event, emit) async {
      user = await getUser();
      if(user != null){
        emit(ProfileState(getUserSuccess: true));
      }
    });
  }
  Future<User?> getUser() async {
    var userRepo = GetIt.instance.get<UserRepo>();
    try {
      user = await userRepo.getUser();
      return user;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}