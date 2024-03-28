import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_app/todo_details/todo_details_screen.dart';
import 'package:my_todo_app/todos/bloc/todos_bloc.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List<TodoModel> todosList = context.select<TodosBloc, List<TodoModel>>(
    // (TodosBloc bloc) => bloc.state.todosList);
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
      body: BlocConsumer<TodosBloc, TodosState>(listener: (context, state) {
        if (state is TodoEditRequestedState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: BlocProvider.of<TodosBloc>(context),
                child: TodoDetailsScreen(),
              ),
            ),
          );
        }
      }, builder: (context, state) {
        TodosBloc bloc = context.read<TodosBloc>();
        debugPrint("Todo Bloc builder called with State: ${state}");
        // debugPrint("with new value: ${state.todosList[0].title}");
        return ListView(
          children: state.todosList
              .map(
                (todo) => Dismissible(
                  background: Container(
                    color: Colors.red,
                  ),
                  // secondaryBackground: Container(
                  //   color: Colors.red,
                  // ),
                  key: Key(todo.id),
                  onDismissed: (value) {
                    debugPrint("Dismissed");
                    bloc.add(OnTodoDelete(todo.id));
                  },
                  child: ListTile(
                    onTap: () {
                      bloc.add(OnTodoDetailsPageRequested(
                          todo.title, todo.description, todo.id));
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
      }),
    );
  }
}
