import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_app/todo_details/bloc/todo_details_bloc.dart';
import 'package:my_todo_app/todos/bloc/todos_bloc.dart';

class TodoDetailsScreen extends StatelessWidget {
  TodoDetailsScreen([bool? isNewTodo, String? title, String? description]) {
    this.isNewTodo = false;
    titleController.text = title ?? "";
    descriptionController.text = description ?? "";
  }
  final TextEditingController titleController =
      TextEditingController(text: 'Title');
  final TextEditingController descriptionController =
      TextEditingController(text: "Description");

  bool? isNewTodo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoDetailsBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Todo Details",
          ),
        ),
        floatingActionButton: MultiBlocListener(
          listeners: [
            BlocListener<TodoDetailsBloc, TodoDetailsState>(
              listener: (blocContext, state) {
                debugPrint("Listener is called with State: $state");
                if (state is TodoDetailsSavedState) {
                  debugPrint("Inside listener saved state");
                  BlocProvider.of<TodosBloc>(context).add(
                    OnTaskAdded(
                        titleController.text, descriptionController.text),
                  );
                  Navigator.pop(context);
                }
              },
            ),
            BlocListener<TodosBloc, TodosState>(
              listener: (blocContext, state) {
                debugPrint("Listener is called with State: $state");
                debugPrint("listener new value: ${state.todosList[0].title}");

                if (state is TodoEditedSuccessState) {
                  debugPrint("Inside success listener saved state");
                  // BlocProvider.of<TodosBloc>(context).add(
                  //   OnTaskAdded(
                  //       titleController.text, descriptionController.text),
                  // );
                  Navigator.pop(context);
                }
              },
            ),
          ],
          child: BlocBuilder<TodoDetailsBloc, TodoDetailsState>(
            builder: (detailsContext, state) => FloatingActionButton(
                child: const Icon(
                  Icons.check,
                ),
                onPressed: () {
                  final todoState = BlocProvider.of<TodosBloc>(context).state;
                  final tdoBloc = BlocProvider.of<TodosBloc>(context);
                  if (todoState is TodoEditRequestedState) {
                    tdoBloc.add(OnTaskDetailsUpdated(todoState.id,
                        titleController.text, descriptionController.text));
                  } else {
                    debugPrint("Reacehd to else");
                    BlocProvider.of<TodoDetailsBloc>(detailsContext).add(
                      OnPressedSaveData(
                        titleController.text,
                        descriptionController.text,
                      ),
                    );
                  }
                  // Navigator.pop(context);
                }),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocBuilder<TodosBloc, TodosState>(
              // bloc: TodosBloc(),
              builder: (context, state) {
            if (state is TodoEditRequestedState) {
              titleController.text = state.title;
              descriptionController.text = state.description;
            }
            return Column(
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
                  decoration: const InputDecoration(
                    label: Text(
                      "Description",
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
