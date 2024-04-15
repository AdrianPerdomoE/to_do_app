import 'package:cloud_firestore/cloud_firestore.dart';
import "../models/task.dart";

class TaskDatabase {
  String collection = 'tasks';
  Future<String?> addTask(Task task) async {
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
    return FirebaseFirestore.instance
        .collection(collection)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Task.fromMap(doc.data(),
            doc.id); // Asegúrate de que tu clase Task tenga un método fromMap
      }).toList();
    });
  }

  Future<void> updateTask(Task task) async {
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
    try {
      await FirebaseFirestore.instance.collection('tasks').doc(taskId).delete();
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
}
