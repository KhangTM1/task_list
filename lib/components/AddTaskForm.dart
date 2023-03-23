import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskForm extends StatefulWidget {
  final Function(String, DateTime) onAddTask;

  AddTaskForm({required this.onAddTask});

  @override
  _AddTaskFormState createState() => _AddTaskFormState();
}
class _AddTaskFormState extends State<AddTaskForm> {
  late TextEditingController _taskController;
  String datatimeS = '';
  DateTime? datatimeDT;
  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController();
  }
  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        TextField(

          controller: _taskController,
          decoration: InputDecoration(
            labelText: 'Task name',

          ),
        ),
        ElevatedButton(
          onPressed: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2015),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              final timePicked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (timePicked != null) {
                print(timePicked);
                setState(() {
                  DateTime _dateTime = DateTime(
                    picked.year,
                    picked.month,
                    picked.day,
                    timePicked.hour,
                    timePicked.minute,
                  );
                  datatimeS = DateFormat.yMd().add_Hm().format(_dateTime!);
                  datatimeDT = _dateTime;
                });
              }
            }
          },
          child: Text(
            datatimeDT == null
                ? 'Pick a date and time'
                : 'Picked date and time: ${DateFormat.yMd().add_Hm().format(datatimeDT!)}',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onAddTask(_taskController.text, datatimeDT!);

            Navigator.of(context).pop();
          },

          child: Text('Add task'),

        ),
      ],
    );
  }
}
