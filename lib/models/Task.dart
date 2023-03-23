class Task {
  final String name;
  final DateTime dateTime;
  bool isDone;
  Task({
    required this.name,
    required this.dateTime,
    this.isDone = false,
  });
}
