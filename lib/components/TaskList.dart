import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Task.dart';

class TaskList extends StatefulWidget {
  final List<Task> tasks;
  final Function(Task) onToggleTask;

  TaskList({required this.tasks, required this.onToggleTask});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  String _formatDeadline(DateTime deadline) {
    Duration duration = deadline.difference(DateTime.now());

    if (duration.inDays > 0) {
      return '${duration.inDays} days left';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} hours left';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} minutes left';
    } else {
      return 'Deadline passed';
    }
  }

  Color _getDeadlineColor(DateTime deadline) {
    Duration duration = deadline.difference(DateTime.now());
    if (duration.isNegative) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        final task = widget.tasks[index];
        Duration duration = task.dateTime.difference(DateTime.now());

        return Card(
          child:ListTile(
            leading: Icon(
              Icons.calendar_today,
              color: _getDeadlineColor(task.dateTime),
            ),
            title: Text(
              task.name,
              style: TextStyle(
                color: _getDeadlineColor(task.dateTime),
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                letterSpacing: 1.5,
                wordSpacing: 2.0,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ],
              ),
            ),
            subtitle: Text(
              _formatDeadline(task.dateTime),
              style: duration.isNegative
                  ? TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              )
                  : TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          )
        );
      },
    );
  }
}

