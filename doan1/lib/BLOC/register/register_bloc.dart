import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/authenticator.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterInfoState>{
  RegisterBloc(): super(RegisterInfoState()){
    on<RegisterEvent>((event,emit) async {
      var authenticator = GetIt.instance.get<Authenticator>();
      try {
        bool registerstate = await authenticator.register(
            event.Username as String,
            event.Password as String,
            event.Email as String,
            event.FirstName as String,
            event.LastName as String,
            event.Phone as String,
            "",
            event.Gender as int);
        if(registerstate) {
          print("Register success");
          emit(RegisterInfoState(registerStatus: RegisterStatus.Success));
        }
      } catch (e)
      {
        print("Register failed");
        emit(RegisterInfoState(
            registerStatus: RegisterStatus.InvalidInfo));
        // timer!.cancel();
      }
    });
  }
}