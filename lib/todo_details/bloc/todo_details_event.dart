part of 'todo_details_bloc.dart';

sealed class TodoDetailsEvent {}

class OnPressedSaveData extends TodoDetailsEvent {
  final String title;
  final String description;
  final TodoModel? todoModel;
  OnPressedSaveData(this.title, this.description, this.todoModel);
}

class OnPressedEditTodo extends TodoDetailsEvent {
  final TodoModel? todoModel;
  OnPressedEditTodo({this.todoModel});
}
