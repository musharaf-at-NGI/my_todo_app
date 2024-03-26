part of 'todo_details_bloc.dart';

sealed class TodoDetailsEvent {}

class OnPressedSaveData extends TodoDetailsEvent {
  final String title;
  final String description;
  OnPressedSaveData(this.title, this.description);
}

class OnPressedCreateTodo extends TodoDetailsEvent {}

class OnPressedEditTodo extends TodoDetailsEvent {
  final String title;
  final String description;
  OnPressedEditTodo(this.title, this.description);
}
