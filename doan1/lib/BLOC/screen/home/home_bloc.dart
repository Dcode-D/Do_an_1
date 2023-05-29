import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  HomeBloc() : super(HomeState(getUserSuccess: false)){
    on<GetUserForScreenEvent>((event, emit) async {
      emit(HomeState(getUserSuccess: true));
    });
  }
}