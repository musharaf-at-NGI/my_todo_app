part of 'bottom_navigation_bloc.dart';

sealed class BottomNavigationState {
  BottomNavigationState(this.tabIndex);
  final int tabIndex;
}

class BottomNavigationInitialState extends BottomNavigationState {
  BottomNavigationInitialState(this.tabIndex) : super(tabIndex);

  final int tabIndex;
}
