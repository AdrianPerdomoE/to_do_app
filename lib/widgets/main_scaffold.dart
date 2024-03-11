import 'package:flutter/material.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/widgets/task_view.dart';

import 'add_task.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State {
  List<Task> taskList = [];
  late double width;
  late double height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        shape: const CircleBorder(),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AddTask(
                    add: addTaskToList,
                  ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: _appBar(),
      body: _body(),
    );
  }

  void addTaskToList(String title, String description) {
    setState(() {
      taskList.add(Task(description: description, title: title, isDone: false));
    });
  }

  void deleteTask(int index) {
    setState(() {
      taskList.removeAt(index);
    });
  }

  AppBar _appBar() {
    return AppBar(
      title: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text('Lista de tareas', style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }

  _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: height * 0.8,
            margin: EdgeInsets.only(top: height * 0.05),
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: createList(),
          )
        ],
      ),
    );
  }

  Widget createList() {
    if (taskList.isEmpty)
      return const Center(
          child: Text(
        'No hay tareas',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ));
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return TaskView(
          index: index,
          onDelete: deleteTask,
          task: taskList[index],
          onChanged: (value) {
            setState(() {
              taskList[index].isDone = value;
            });
          },
        );
      },
    );
  }
}
