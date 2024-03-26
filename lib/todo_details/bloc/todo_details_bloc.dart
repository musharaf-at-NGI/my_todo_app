import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'todo_details_event.dart';
part 'todo_details_state.dart';

class TodoDetailsBloc extends Bloc<TodoDetailsEvent, TodoDetailsState> {
  static String title = "";
  static String description = "";

  TodoDetailsBloc() : super(TodoDetailsEditingState(title, description)) {
    on<OnPressedSaveData>((event, emit) async {
      debugPrint("onPressed Called");
      emit(TodoDetailsSavedState(event.title, event.description));
      debugPrint("State emitted");
    });
    
    on<OnPressedCreateTodo>(
      (event, emit) {},
    );
  }
}
