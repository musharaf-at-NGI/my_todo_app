import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_app/todos/models/todo_model.dart';
import 'package:my_todo_app/todos/repository/todos_repository.dart';
part 'todo_details_event.dart';
part 'todo_details_state.dart';

class TodoDetailsBloc extends Bloc<TodoDetailsEvent, TodoDetailsState> {
  TodoDetailsBloc() : super(TodoDetailsEditingState()) {
    on<OnPressedSaveData>((event, emit) async {
      TodoModel? todo = event.todoModel;
      if (todo != null) {
        todo.title = event.title;
        todo.description = event.description;
        await TodosRepository().updateTodo(todo);
      } else {
        todo = TodoModel(
          id: DateTime.now().toIso8601String(),
          title: event.title,
          description: event.description,
          isCompleted: false,
        );
        await TodosRepository().addTodo(todo);
      }
      emit(TodoDetailsSavedState());
    });

    on<OnPressedEditTodo>(
      (event, emit) {},
    );
  }
}
