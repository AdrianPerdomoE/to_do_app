import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskView extends StatelessWidget {
  Task task;
  Function(bool) onChanged;
  TaskView({super.key, required this.task, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      tileColor: Colors.grey.shade700,
      title: Text(task.title, style: getTextStyle()),
      subtitle: Text(task.description, style: getTextStyle()),
      leading: Checkbox(
        value: task.isDone,
        onChanged: (value) => onChanged(value ?? false),
      ),
      trailing: PopupMenuButton(
        offset: const Offset(-25, 40),
        itemBuilder: (BuildContext context) {
          return [
            const PopupMenuItem(
              child: Center(child: Icon(Icons.edit)),
            ),
            const PopupMenuItem(
              child: Center(child: Icon(Icons.delete)),
            ),
          ];
        },
      ),
    );
  }

  getTextStyle() {
    return TextStyle(
        decoration:
            task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
        decorationColor: Colors.red,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 2.85,
        color: task.isDone ? Colors.grey : Colors.white);
  }
}
