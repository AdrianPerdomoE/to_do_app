import 'package:flutter/material.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/widgets/task_view.dart';
import '../controllers/task_database.dart';
import 'add_task.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State {
  late Stream<List<Task>> taskList;
  final TaskDatabase _taskDatabase = TaskDatabase();
  late double width;
  late double height;
  @override
  Widget build(BuildContext context) {
    taskList = _taskDatabase.getTasks();
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
    //se conecta la funcion previa con la nueva funcion de la db para agregar una tarea
    setState(() {
      _taskDatabase
          .addTask(Task(description: description, title: title, isDone: false));
    });
  }

  void deleteTask(String id) {
    setState(() {
      _taskDatabase.deleteTask(id);
    });
  }

  void update(Task task) {
    setState(() {
      _taskDatabase.updateTask(task);
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
          SizedBox(
            height: height * 0.05,
          ),
          Expanded(
            child: createList(),
          )
        ],
      ),
    );
  }

  Widget createList() {
    return StreamBuilder(
        //se utiliza el streambuilder para actualizar la lista de tareas en tiempo real
        stream: taskList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Task> taskList = snapshot.data as List<Task>;
            if (taskList.isEmpty) {
              return const Center(
                  child: Text(
                'No hay tareas',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ));
            }
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                return TaskView(
                  update: update,
                  index: index,
                  onDelete: deleteTask,
                  task: taskList[index],
                  onChanged: (value) {
                    setState(() {
                      taskList[index].isDone = value;
                      update(taskList[index]);
                    });
                  },
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
