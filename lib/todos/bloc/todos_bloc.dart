import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/todo_model.dart';
part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  List<TodoModel> todos = [];

  int getCompletedTodos() {
    return state.todosList
        .where((element) => element.isCompleted)
        .toList()
        .length;
  }

  int getActiveTodos() {
    return state.todosList
        .where((element) => !element.isCompleted)
        .toList()
        .length;
  }

  TodosBloc() : super(InitialState([])) {
    on<LoadInitialTodos>((event, emit) {
      state.todosList = event.todosList;
      todos = state.todosList;
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
      todos = state.todosList;
      emit(InitialState(state.todosList));
    });

    on<OnTaskAdded>(
      (event, emit) {
        state.todosList = state.todosList +
            [
              TodoModel(
                  id: DateTime.now().toUtc().toString(),
                  title: event.title,
                  description: event.description,
                  isCompleted: false)
            ];
        todos = state.todosList;
        emit(InitialState(state.todosList));
      },
    );

    on<OnTodoDetailsPageRequested>(
      (event, emit) {
        emit(
          TodoEditRequestedState(
            state.todosList,
            event.title,
            event.description,
            event.id,
          ),
        );
      },
    );

    on<OnTaskDetailsUpdated>(
      (event, emit) async {
        state.todosList = state.todosList.map((todo) {
          if (todo.id == event.id) {
            todo.title = event.title;
            todo.description = event.description;
          }
          return todo;
        }).toList();
        todos = state.todosList;
        emit(TodoEditedSuccessState(state.todosList));
      },
    );

    on<OnTappedShowActive>(
      (event, emit) {
        state.todosList =
            todos.where((element) => !element.isCompleted).toList();
        emit(InitialState(state.todosList));
      },
    );

    on<OnTappedShowCompleted>(
      (event, emit) {
        state.todosList =
            todos.where((element) => element.isCompleted).toList();
        emit(InitialState(state.todosList));
      },
    );

    on<OnTappedShowAll>(
      (event, emit) {
        emit(InitialState(todos));
      },
    );

    on<OnMarkAllActive>(
      (event, emit) {
        todos = todos.map((e) => e..isCompleted = false).toList();
        state.todosList =
            state.todosList.map((e) => e..isCompleted = false).toList();

        emit(InitialState(state.todosList));
      },
    );

    on<OnMarkAllComplete>(
      (event, emit) {
        todos = todos.map((e) => e..isCompleted = true).toList();
        state.todosList =
            state.todosList.map((e) => e..isCompleted = true).toList();
        emit(InitialState(state.todosList));
      },
    );
  }
}
