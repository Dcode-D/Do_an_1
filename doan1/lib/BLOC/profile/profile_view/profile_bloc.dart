import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doan1/EventBus/Events/TestEvent.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/model/user.dart';
import '../../../data/repositories/user_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent,ProfileState>{
  User? user;
  String? image;
  ProfileBloc(BuildContext context): super(ProfileState(getUserSuccess: false)){
    on<getProfileScreenEvent>((event, emit) async {
      var baseUrl = GetIt.instance.get<Dio>().options.baseUrl;
      // var eventBus = GetIt.instance.get<EventBus>();
      // eventBus.on<EBTestEvent>().listen((event) {
      //   print(event.msg);
      // });
      emit(ProfileState(getUserSuccess: false));
      user = await getUser();
      if(user != null){
        var userRepo = GetIt.instance.get<UserRepository>();
        var images = await userRepo.getListAvatarId(user!.id);
        image = '$baseUrl/avatar/${images!.last}';
        emit(ProfileState(getUserSuccess: true));
      }
    });
  }
  Future<User?> getUser() async {
    var userRepo = GetIt.instance.get<UserRepository>();
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