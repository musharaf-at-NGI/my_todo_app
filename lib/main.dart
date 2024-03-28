import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_app/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:my_todo_app/bottom_navigation/bottom_navigation_screen.dart';
import 'package:my_todo_app/todos/bloc/todos_bloc.dart';

import 'todos/repository/todos_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TodosRepository();
  await Future.delayed(const Duration(seconds: 1));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter To Do App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider(
          create: (_) => BottomNavigationBloc(),
        ),
        BlocProvider(
          create: (_) => TodosBloc()..add(LoadInitialTodos()),
        ),
        // BlocProvider(
        //   create: (_) => TodoDetailsBloc(),
        // ),
      ], child: const BottomNavigationScreen()),
    );
  }
}
