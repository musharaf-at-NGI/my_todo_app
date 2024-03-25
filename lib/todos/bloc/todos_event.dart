part of 'todos_bloc.dart';

sealed class TodosEvent {}


class LoadInitialTodos extends TodosEvent {
  LoadInitialTodos(this.todosList);
  List<TodoModel> todosList;
}

class OnTaskUpdated extends TodosEvent {
  bool value;
  String id;
  OnTaskUpdated(this.id, this.value);
}
