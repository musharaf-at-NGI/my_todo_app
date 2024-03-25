import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navigation_state.dart';
part 'buttom_navigation_event.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(BottomNavigationInitialState(0)) {
    on<OnNavBarTabbed>(
      (event, emit) {
        emit(BottomNavigationInitialState(event.index));
      },
    );
  }
}
