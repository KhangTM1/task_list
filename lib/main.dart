import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Task.dart';
import '../components/TaskList.dart';
import '../components/AddTaskForm.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Task> _tasks = [];

  void _addTask(String name, DateTime dateTime) {
    setState(() {
      _tasks.add(Task(name: name, dateTime: dateTime));
    });
  }

  void _toggleTask(Task task) {
    setState(() {
      task.isDone = !task.isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quản lý công việc'),
        ),
        body: Column(

          children: [
            Expanded(
              child: TaskList(tasks: _tasks, onToggleTask: _toggleTask),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await showModalBottomSheet(
              context: context,
              builder: (context) => AddTaskForm(onAddTask: _addTask),
            );
            if (result != null && result is Task) {
              _addTask(result.name, result.dateTime);
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}