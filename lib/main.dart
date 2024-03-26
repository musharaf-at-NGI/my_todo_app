import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_app/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:my_todo_app/bottom_navigation/bottom_navigation_screen.dart';
import 'package:my_todo_app/todo_details/bloc/todo_details_bloc.dart';
import 'package:my_todo_app/todos/bloc/todos_bloc.dart';
import 'package:my_todo_app/todos/models/todo_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider(
          create: (_) => BottomNavigationBloc(),
        ),
        BlocProvider(
          create: (_) => TodosBloc()
            ..add(LoadInitialTodos([
              TodoModel(
                  id: DateTime.now().toUtc().toString(),
                  title: "Task 1",
                  description: "description",
                  isCompleted: false)
            ])),
        ),
        // BlocProvider(
        //   create: (_) => TodoDetailsBloc(),
        // ),
      ], child: const BottomNavigationScreen()),
    );
  }
}
