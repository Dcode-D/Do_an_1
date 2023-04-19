import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationInfoState> {

  NavigationBloc() : super(NavigationInfoState(selectedIndex: 0)) {
    on<NavigateEvent>((event, emit) => emit(NavigationInfoState(selectedIndex: event.selectedIndex)));
  }
}