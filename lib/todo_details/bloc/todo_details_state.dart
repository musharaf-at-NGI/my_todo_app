part of 'todo_details_bloc.dart';

sealed class TodoDetailsState {
  TodoDetailsState();
}

class TodoDetailsEditingState extends TodoDetailsState {
  TodoDetailsEditingState() : super();
}

class TodoDetailsSavedState extends TodoDetailsState {
  TodoDetailsSavedState();
}
