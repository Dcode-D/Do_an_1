part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState {}

class NavigationInfoState extends NavigationState {
  int selectedIndex = 0;
  NavigationInfoState({required this.selectedIndex}) {
  }
}
