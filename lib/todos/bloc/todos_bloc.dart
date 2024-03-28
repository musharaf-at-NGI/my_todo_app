import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_app/todos/repository/todos_repository.dart';
import '../models/todo_model.dart';
part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  // List<TodoModel> todos = [];
  TodosRepository todosRepository = TodosRepository();

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
      state.todosList = todosRepository.allTodos;
      // todos = state.todosList;
      debugPrint("emitted state");
      emit(state);
    });

    on<OnTaskUpdated>((event, emit) async {
      TodoModel todo =
          state.todosList.firstWhere((element) => element.id == event.id);
      todo.isCompleted = event.value;
      await todosRepository.updateTodo(todo);
      emit(InitialState(todosRepository.allTodos));
    });

    on<OnTaskAdded>(
      (event, emit) async {
        await todosRepository.addTodo(
          TodoModel(
            id: DateTime.now().toUtc().toString(),
            title: event.title,
            description: event.description,
            isCompleted: false,
          ),
        );
        emit(InitialState(todosRepository.allTodos));
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
        TodoModel todo =
            state.todosList.firstWhere((element) => element.id == event.id);
        todo.title = event.title;
        todo.description = event.description;
        await todosRepository.updateTodo(todo);
        emit(TodoEditedSuccessState(todosRepository.allTodos));
      },
    );

    on<OnTappedShowActive>(
      (event, emit) {
        emit(InitialState(todosRepository.fetchActiveTodos()));
      },
    );

    on<OnTappedShowCompleted>(
      (event, emit) {
        // state.todosList =
        //     todos.where((element) => element.isCompleted).toList();
        emit(InitialState(todosRepository.fetchCompletedTodos()));
      },
    );

    on<OnTappedShowAll>(
      (event, emit) {
        emit(InitialState(todosRepository.allTodos));
      },
    );

    on<OnMarkAllActive>(
      (event, emit) async {
        // todos = todos.map((e) => e..isCompleted = false).toList();
        // state.todosList =
        //     state.todosList.map((e) => e..isCompleted = false).toList();

        await todosRepository.markAllTodosActive();

        emit(InitialState(todosRepository.allTodos));
      },
    );

    on<OnMarkAllComplete>(
      (event, emit) async {
        // todos = todos.map((e) => e..isCompleted = true).toList();
        // state.todosList =
        //     state.todosList.map((e) => e..isCompleted = true).toList();

        await todosRepository.markAllTodosCompleted();

        emit(InitialState(todosRepository.allTodos));
      },
    );

    on<OnTodoDelete>(
      (event, emit) async {
        await todosRepository.deleteTodo(event.id);

        state.todosList = todosRepository.allTodos;
        // todos = state.todosList;
        // state.todosList =
        //     state.todosList.where((element) => element.id != event.id).toList();
        // todos = todos.where((element) => element.id != event.id).toList();
        emit(InitialState(state.todosList));
      },
    );
  }
}
