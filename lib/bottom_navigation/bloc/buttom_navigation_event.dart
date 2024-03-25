part of 'bottom_navigation_bloc.dart';

sealed class BottomNavigationEvent {}

class OnNavBarTabbed extends BottomNavigationEvent {
  OnNavBarTabbed(this.index);
  int index;
}
