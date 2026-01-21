import 'package:cloud_firestore/cloud_firestore.dart';

/// Service class for handling Firestore operations
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Reference to the tasks collection
  CollectionReference get tasksCollection => _firestore.collection('tasks');

  /// Add a new task
  /// Returns the document ID of the newly created task
  Future<String> addTask(String title, String userId) async {
    try {
      final docRef = await tasksCollection.add({
        'title': title,
        'userId': userId,
        'completed': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return docRef.id;
    } catch (e) {
      throw 'Error adding task: $e';
    }
  }

  /// Get all tasks for a specific user as a Stream (real-time updates)
  Stream<QuerySnapshot> getUserTasks(String userId) {
    return tasksCollection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Get all tasks for a specific user as a Future (one-time fetch)
  Future<List<Map<String, dynamic>>> getUserTasksOnce(String userId) async {
    try {
      final snapshot = await tasksCollection
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    } catch (e) {
      throw 'Error fetching tasks: $e';
    }
  }

  /// Update task completion status
  Future<void> updateTaskStatus(String taskId, bool completed) async {
    try {
      await tasksCollection.doc(taskId).update({
        'completed': completed,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw 'Error updating task: $e';
    }
  }

  /// Update task title
  Future<void> updateTaskTitle(String taskId, String newTitle) async {
    try {
      await tasksCollection.doc(taskId).update({
        'title': newTitle,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw 'Error updating task: $e';
    }
  }

  /// Delete a task
  Future<void> deleteTask(String taskId) async {
    try {
      await tasksCollection.doc(taskId).delete();
    } catch (e) {
      throw 'Error deleting task: $e';
    }
  }

  /// Delete all tasks for a user
  Future<void> deleteAllUserTasks(String userId) async {
    try {
      final snapshot = await tasksCollection
          .where('userId', isEqualTo: userId)
          .get();

      final batch = _firestore.batch();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      throw 'Error deleting tasks: $e';
    }
  }

  /// Get task count for a user
  Future<int> getTaskCount(String userId) async {
    try {
      final snapshot = await tasksCollection
          .where('userId', isEqualTo: userId)
          .count()
          .get();
      return snapshot.count ?? 0;
    } catch (e) {
      throw 'Error counting tasks: $e';
    }
  }
}
