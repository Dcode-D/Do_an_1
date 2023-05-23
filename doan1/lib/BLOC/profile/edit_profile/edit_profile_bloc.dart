import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileState(isPassWordVisible: false, isPassWordConfirmVisible: false)) {
    on<CheckPasswordVisibilityEvent>((event, emit) => emit(
        EditProfileState(isPassWordVisible: event.isPassWordVisible, isPassWordConfirmVisible: state.isPassWordConfirmVisible)));

    on<CheckPasswordConfirmVisibilityEvent>((event, emit) => emit(
        EditProfileState(isPassWordVisible: state.isPassWordVisible, isPassWordConfirmVisible: event.isPassWordConfirmVisible)));

  }
}