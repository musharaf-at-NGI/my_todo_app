import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_app/todo_details/todo_details_screen.dart';
import 'package:my_todo_app/todos/bloc/todos_bloc.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TodosBloc bloc = context.read<TodosBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Todos"),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.filter_list_rounded),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text("Show all"),
                onTap: () {
                  bloc.add(OnTappedShowAll());
                },
              ),
              PopupMenuItem(
                onTap: () {
                  bloc.add(OnTappedShowCompleted());
                },
                child: const Text("Show completed"),
              ),
              PopupMenuItem(
                onTap: () {
                  bloc.add(OnTappedShowActive());
                },
                child: const Text("Show active"),
              )
            ],
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                  onTap: () {
                    bloc.add(OnMarkAllComplete());
                  },
                  child: const Text("Mark all complete")),
              PopupMenuItem(
                  onTap: () {
                    bloc.add(OnMarkAllActive());
                  },
                  child: const Text("Mark all active")),
            ],
          ),
        ],
      ),
      body: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          TodosBloc bloc = context.read<TodosBloc>();
          return ListView(
            children: state.todosList
                .map(
                  (todo) => Dismissible(
                    background: Container(
                      color: Colors.red,
                    ),
                    key: Key(todo.id),
                    onDismissed: (value) {
                      debugPrint("Dismissed");
                      bloc.add(OnTodoDelete(todo.id));
                    },
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          TodoDetailsScreen.todoDetailsScreenRoute(
                            todo: todo,
                            todosBloc: context.read<TodosBloc>(),
                          ),
                        );
                      },
                      leading: Checkbox(
                        value: todo.isCompleted,
                        onChanged: (value) {
                          bloc.add(OnTaskUpdated(todo.id, value!));
                        },
                      ),
                      title: Text(todo.title),
                      subtitle: Text(todo.description),
                      trailing: const Icon(Icons.arrow_right_outlined),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
