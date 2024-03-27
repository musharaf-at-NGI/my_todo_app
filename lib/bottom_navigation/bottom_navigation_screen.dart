import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_app/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:my_todo_app/stats/stats_screen.dart';
import 'package:my_todo_app/todos/bloc/todos_bloc.dart';
import 'package:my_todo_app/todos/todos_screen.dart';
import '../todo_details/todo_details_screen.dart';

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("rebuild Called");
    int index =
        context.select((BottomNavigationBloc bloc) => bloc.state.tabIndex);
    BottomNavigationBloc bloc = context.read<BottomNavigationBloc>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: BlocProvider.of<TodosBloc>(context),
                child: TodoDetailsScreen(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(
        index: index,
        children: const [TodosScreen(), StatsScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded), label: "Todos"),
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart_outlined), label: "Stats"),
        ],
        onTap: (value) {
          debugPrint("tab changed: $value");
          bloc.add(OnNavBarTabbed(value));
        },
      ),
    );
  }
}
