part of 'todo_details_bloc.dart';

sealed class TodoDetailsState {
  final String title;
  final String description;
  TodoDetailsState(this.title, this.description);
}

class TodoDetailsEditingState extends TodoDetailsState {
  final String title;
  final String description;
  TodoDetailsEditingState(this.title, this.description)
      : super(title, description);
}

class TodoDetailsSavedState extends TodoDetailsState {
  final String title;
  final String description;
  TodoDetailsSavedState(this.title, this.description)
      : super(title, description);
}
