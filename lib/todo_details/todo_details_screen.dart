import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_app/todo_details/bloc/todo_details_bloc.dart';
import 'package:my_todo_app/todos/models/todo_model.dart';

import '../todos/bloc/todos_bloc.dart';

class TodoDetailsScreen extends StatelessWidget {
  TodoDetailsScreen({this.todo}) : super();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TodoModel? todo;

  static Route<void> todoDetailsScreenRoute(
      {TodoModel? todo, required TodosBloc todosBloc}) {
    return MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TodoDetailsBloc(),
          ),
          BlocProvider.value(value: todosBloc)
        ],
        child: TodoDetailsScreen(
          todo: todo,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (todo != null) {
      titleController.text = todo!.title;
      descriptionController.text = todo!.description;
    }

    return BlocListener<TodoDetailsBloc, TodoDetailsState>(
      listener: (listenerContext, state) {
        debugPrint("Listener is called with State: $state");
        if (state is TodoDetailsSavedState) {
          context.read<TodosBloc>().add(
                OnTodoSuccessfullyAddedUpdated(),
              );
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Todo Details",
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.check,
            ),
            onPressed: () {
              // final todoState = BlocProvider.of<TodosBloc>(context).state;
              // final tdoBloc = BlocProvider.of<TodosBloc>(context);
              // if (todoState is TodoEditRequestedState) {
              //   tdoBloc.add(OnTaskDetailsUpdated(todoState.id,
              //       titleController.text, descriptionController.text));
              // } else {
              context.read<TodoDetailsBloc>().add(
                    OnPressedSaveData(
                        titleController.text, descriptionController.text, todo),
                  );
              // }
            }),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(label: Text("Title")),
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                controller: descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(label: Text("Description")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
