class Task {
  late String id;
  String title;
  String description;
  bool isDone;

  Task({required this.title, required this.description, required this.isDone});
  Task.fromMap(Map<String, dynamic> map, String idTask)
      : title = map['title'] ?? "",
        description = map['description'] ?? '',
        isDone = map['isDone'] ?? '',
        id = idTask;

  toMap() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }
}
