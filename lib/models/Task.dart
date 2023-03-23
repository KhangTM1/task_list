class Task {
  final String name;
  final DateTime dateTime;
  bool isDone;
//   Color color;
  Task({
    required this.name,
    required this.dateTime,
    this.isDone = false,
  });
}
