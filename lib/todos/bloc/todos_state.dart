part of 'todos_bloc.dart';

sealed class TodosState {
  TodosState(this.todosList);
  List<TodoModel> todosList = [];
}

class InitialState extends TodosState {
  List<TodoModel> todosList;

  InitialState(this.todosList) : super(todosList);
}

class TodoEditRequestedState extends TodosState {
  List<TodoModel> todosList;
  String title;
  String description;
  String id;
  TodoEditRequestedState(this.todosList, this.title, this.description, this.id)
      : super(todosList);
}

class TodoEditedSuccessState extends TodosState {
  List<TodoModel> todosList;
  TodoEditedSuccessState(this.todosList) : super(todosList);
}
