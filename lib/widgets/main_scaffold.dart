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
  List<Task> taskList = [
    Task(description: "una tarea", isDone: false, title: "titulo")
  ];
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
          _showDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      appBar: _appBar(),
      body: _body(),
    );
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
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: createList(),
          )
        ],
      ),
    );
  }

  Widget createList() {
    return ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return TaskView(
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

  _showDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const AddTask());
  }
}
