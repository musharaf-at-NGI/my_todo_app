import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_app/todos/bloc/todos_bloc.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stats"),
      ),
      body: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) => Column(
          children: [
            ListTile(
              leading: const Icon(Icons.check),
              title: const Text("Completed todos"),
              trailing: Text("${context.read<TodosBloc>().getCompletedTodos()}",
                  style: const TextStyle(fontSize: 18)),
            ),
            ListTile(
              leading: const Icon(Icons.circle_outlined),
              title: const Text("Active todos"),
              trailing: Text("${context.read<TodosBloc>().getActiveTodos()}",
                  style: const TextStyle(fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }
}
