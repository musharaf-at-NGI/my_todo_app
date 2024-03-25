class TodoModel {
  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });
  bool isCompleted;
  String title;
  String description;
  String id;
}
