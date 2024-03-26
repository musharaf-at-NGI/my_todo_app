import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        actions: const [
          Icon(Icons.filter_list),
          Icon(Icons.more_vert_rounded),
        ],
      ),
      body: BlocBuilder<TodosBloc, TodosState>(
        
          //   buildWhen: (pre, cure) {
          //   debugPrint("build When Called");
          //   return true;
          // },
          
          builder: (context, state) {
        return ListView(
          children: state.todosList
              .map(
                (todo) => ListTile(
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
              )
              .toList(),
        );
      }),
    );
  }
}
