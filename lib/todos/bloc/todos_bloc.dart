import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_app/todos/repository/todos_repository.dart';
import '../models/todo_model.dart';
part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosRepository todosRepository = TodosRepository();

  int getCompletedTodos() =>
      state.todosList.where((element) => element.isCompleted).toList().length;

  int getActiveTodos() =>
      state.todosList.where((element) => !element.isCompleted).toList().length;

  TodosBloc() : super(InitialState([])) {
    on<LoadInitialTodos>(
        (event, emit) => emit(InitialState(todosRepository.allTodos)));

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

    on<OnTodoDetailsPageRequested>((event, emit) => emit(TodoEditRequestedState(
        state.todosList, event.title, event.description, event.id)));

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

    on<OnTappedShowActive>((event, emit) =>
        emit(InitialState(todosRepository.fetchActiveTodos())));

    on<OnTappedShowCompleted>((event, emit) =>
        emit(InitialState(todosRepository.fetchCompletedTodos())));

    on<OnTappedShowAll>(
      (event, emit) {
        emit(InitialState(todosRepository.allTodos));
      },
    );

    on<OnMarkAllActive>(
      (event, emit) async {
        await todosRepository.markAllTodosActive();
        emit(InitialState(todosRepository.allTodos));
      },
    );

    on<OnMarkAllComplete>(
      (event, emit) async {
        await todosRepository.markAllTodosCompleted();
        emit(InitialState(todosRepository.allTodos));
      },
    );

    on<OnTodoDelete>(
      (event, emit) async {
        await todosRepository.deleteTodo(event.id);
        emit(InitialState(todosRepository.allTodos));
      },
    );
  }
}
