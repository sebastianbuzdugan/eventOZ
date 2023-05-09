import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // ... other methods ...

  Future<void> deleteTask(String taskId) async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('userTasks')
        .doc(taskId)
        .delete();
  }
}