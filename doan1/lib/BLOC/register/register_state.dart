part of 'register_bloc.dart';

enum RegisterStatus
  { Initial ,InvalidInfo, Success }

@immutable
abstract class RegisterState {}

class RegisterInfoState extends RegisterState {
  RegisterStatus registerStatus = RegisterStatus.Initial;
  RegisterInfoState({RegisterStatus registerStatus = RegisterStatus.Initial}) {
    this.registerStatus = registerStatus;
  }
}