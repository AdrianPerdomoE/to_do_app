import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/edit_task.dart';

import '../models/task.dart';

class TaskView extends StatelessWidget {
  Task task;
  Function(int index) onDelete;
  Function(bool) onChanged;
  int index;
  TaskView(
      {super.key,
      required this.task,
      required this.onChanged,
      required this.onDelete,
      required this.index});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: ListTile(
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
              PopupMenuItem(
                onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return EditTask(currentTask: task);
                    }),
                child: const Center(child: Icon(Icons.edit)),
              ),
              PopupMenuItem(
                onTap: () => onDelete(index),
                child: const Center(child: Icon(Icons.delete)),
              ),
            ];
          },
        ),
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
