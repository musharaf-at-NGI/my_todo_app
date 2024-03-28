import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_todo_app/todos/models/todo_model.dart';
import 'package:path_provider/path_provider.dart';

class TodosRepository {
  static final TodosRepository _instance = TodosRepository._internal();
  static List<TodoModel> _allTodos = [];
  static List<TodoModel> _filteredTodos = [];
  late final Box _box;
  factory TodosRepository() {
    return _instance;
  }

  List<TodoModel> get allTodos => _allTodos;
  List<TodoModel> get filteredTodos => _filteredTodos;

  TodosRepository._internal() {
    debugPrint("Initialing DB");
    getApplicationDocumentsDirectory().then((Directory appDocumentsDir) {
      debugPrint("path: ${appDocumentsDir.path}");
      return Hive.openBox("Todos", path: appDocumentsDir.path);
    }).then((value) {
      _box = value;
      // _box.clear();
      fetchTodos();
      debugPrint("Initialied");
    });
  }

  Future<List<TodoModel>> fetchTodos() async {
    debugPrint("all keys: ${_box.keys}");
    var keys = _box.keys;
    List<TodoModel> list = [];
    for (final key in keys) {
      // debugPrint("all Todos: ${}");
      var todo = await _box.get(key);
      debugPrint("Todo: $todo");
      TodoModel todoModel = TodoModel(
        id: todo["id"],
        title: todo["title"],
        description: todo["description"],
        isCompleted: todo["isCompleted"],
      );
      list.add(todoModel);
      // _allTodos.add(todoModel);
      // _filteredTodos.add(todoModel);
      // debugPrint("isCompleted ${list[0].isCompleted}");
      // todoModel.isCompleted = true;
      // debugPrint("isCompleted ${list[0].isCompleted}");
    }
    _allTodos = list;
    _filteredTodos = list;

    // _filteredTodos = List.from(list.map((e) => e));
    // debugPrint("list 1 ${list[0].isCompleted}");
    // debugPrint("list 2 ${_allTodos[0].isCompleted}");
    // list[0].isCompleted = true;
    // debugPrint("list 1 ${list[0].isCompleted}");
    // debugPrint("list 2 ${_allTodos[0].isCompleted}");

    return list;
  }

  List<TodoModel> fetchActiveTodos() {
    return _allTodos.where((element) => !element.isCompleted).toList();
  }

  List<TodoModel> fetchCompletedTodos() {
    return _allTodos.where((element) => element.isCompleted).toList();
  }

  Future<void> addTodo(TodoModel todo) async {
    await _box.put(todo.id, {
      "id": todo.id,
      "title": todo.title,
      "description": todo.description,
      "isCompleted": todo.isCompleted
    });
    _allTodos.add(todo);
  }

  Future<void> updateTodo(TodoModel todo) async {
    await _box.put(todo.id, {
      "id": todo.id,
      "title": todo.title,
      "description": todo.description,
      "isCompleted": todo.isCompleted
    });

    int index = _allTodos.indexWhere((element) => element.id == todo.id);
    _allTodos[index] = todo;
  }

  Future<void> deleteTodo(String id) async {
    debugPrint("Delete item with id: $id");
    await _box.delete(id);
    _allTodos.removeWhere((element) => element.id == id);
  }

  Future<void> markAllTodosCompleted() async {
    debugPrint("Reached to compelte all");
    for (final todo in _allTodos) {
      debugPrint("Reached to inside loop");
      if (todo.isCompleted == false) {
        todo.isCompleted = true;
        debugPrint("Reached inside condition");
        await updateTodo(todo);
      }
    }
  }

  Future<void> markAllTodosActive() async {
    for (final todo in _allTodos) {
      if (todo.isCompleted) {
        todo.isCompleted = false;
        await updateTodo(todo);
      }
    }
  }
}
