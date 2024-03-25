part of 'todos_bloc.dart';

sealed class TodosState {
  TodosState(this.todosList);
  List<TodoModel> todosList = [];
}

class InitialState extends TodosState {
  List<TodoModel> todosList;

  InitialState(this.todosList) : super(todosList);
}
