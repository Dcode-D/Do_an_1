part of 'navigation_bloc.dart';

abstract class NavigationEvent {}
class NavigateEvent extends NavigationEvent{
  int selectedIndex = 0;
  NavigateEvent({required this.selectedIndex});
}