import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_app/todo_details/bloc/todo_details_bloc.dart';
import 'package:my_todo_app/todos/bloc/todos_bloc.dart';

class TodoDetailsScreen extends StatelessWidget {
  TodoDetailsScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoDetailsBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Todo Details",
          ),
        ),
        floatingActionButton: BlocConsumer<TodoDetailsBloc, TodoDetailsState>(
            // bloc: TodoDetailsBloc(),
            listener: (blocContext, state) {
          debugPrint("Listener is called");
          if (state is TodoDetailsSavedState) {
            debugPrint("inside listener saved state");
            BlocProvider.of<TodosBloc>(context).add(
              OnTaskAdded(titleController.text, descriptionController.text),
            );
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          debugPrint("Todo Bloc Builder called with State $state");
          return FloatingActionButton(
              child: const Icon(
                Icons.check,
              ),
              onPressed: () {
                context.read<TodoDetailsBloc>().add(
                      OnPressedSaveData(
                        titleController.text,
                        descriptionController.text,
                      ),
                    );
                // Navigator.pop(context);
              });
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
                decoration: const InputDecoration(
                  label: Text(
                    "Description",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
