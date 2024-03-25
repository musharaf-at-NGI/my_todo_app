import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/todo_model.dart';
part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  List<TodoModel> todos = [];

  TodosBloc() : super(InitialState([])) {
    on<LoadInitialTodos>((event, emit) {
      state.todosList = event.todosList;
      debugPrint("emitted state");
      emit(state);
    });

    on<OnTaskUpdated>((event, emit) {
      debugPrint("on Task Updated event called");
      debugPrint("previous Value: ${state.todosList[0].isCompleted}");

      state.todosList = state.todosList.map((task) {
        if (task.id == event.id) {
          task.isCompleted = event.value;
        }
        return task;
      }).toList();
      debugPrint("state emitted");
      // print(state);
      debugPrint("updated Value: ${state.todosList[0].isCompleted}");
      state.todosList = [];
      emit(state);
    });
  }
}
