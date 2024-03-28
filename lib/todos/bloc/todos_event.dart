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

class OnTaskDetailsUpdated extends TodosEvent {
  String id;
  String title;
  String description;
  OnTaskDetailsUpdated(this.id, this.title, this.description);
}

class OnTaskAdded extends TodosEvent {
  String title;
  String description;
  OnTaskAdded(this.title, this.description);
}

class OnTodoDetailsPageRequested extends TodosEvent {
  String title;
  String description;
  String id;
  OnTodoDetailsPageRequested(this.title, this.description, this.id);
}

class OnTappedShowAll extends TodosEvent {}

class OnTappedShowCompleted extends TodosEvent {}

class OnTappedShowActive extends TodosEvent {}

class OnMarkAllComplete extends TodosEvent {}

class OnMarkAllActive extends TodosEvent {}

class OnTodoDelete extends TodosEvent {
  String id;
  OnTodoDelete(this.id);
}
