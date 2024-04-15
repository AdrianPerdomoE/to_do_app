import 'package:cloud_firestore/cloud_firestore.dart';
import "../models/task.dart";

class TaskDatabase {
  String collection = 'tasks';
  Future<String?> addTask(Task task) async {
    //funcione para agregar una tarea a la base de datos
    try {
      return FirebaseFirestore.instance
          .collection(collection)
          .add(task.toMap())
          .toString();
    } catch (e) {
      print('Error adding task: $e');
      return null;
    }
  }

  Stream<List<Task>> getTasks() {
    //funcion que retorna una lista de tareas en forma de stream para que se actualice en tiempo real
    return FirebaseFirestore.instance
        .collection(collection)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Task.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> updateTask(Task task) async {
    //funcion para actualizar una tarea en la base de datos
    try {
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(task.id)
          .update(task.toMap());
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    //funcion para eliminar una tarea de la base de datos
    try {
      await FirebaseFirestore.instance.collection('tasks').doc(taskId).delete();
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
}
