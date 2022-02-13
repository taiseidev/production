import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:myproduction/notificationApp/utils/convert_datetime.dart';
import 'package:myproduction/notificationApp/utils/firestore_auth.dart';
import 'package:uuid/uuid.dart';

class FirestoreRepository {
  static Future<void> setTask(String task) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuthUtills.uid)
        .collection('task')
        .add(
      {
        'task': task,
        'createdAt': ConvertDateTime.outputFormat.format(
          DateTime.now(),
        ),
      },
    );
  }

  static Future setNotificationTask(
      String task, TextEditingController notificationTime) async {
    var uuid = Uuid();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuthUtills.uid)
        .collection('notificationTask')
        .add({
      'notificationTask': task,
      'notificationTime': int.parse(notificationTime.text),
      'createdAt': DateTime.now(),
      'id': uuid.v4(),
    });
  }

// タスクを昇順で取得
  static Query<Map<String, dynamic>> getTaskData() {
    final querySnapshot = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuthUtills.uid)
        .collection('task')
        .orderBy('createdAt', descending: true);

    return querySnapshot;
  }

  static Query<Map<String, dynamic>> getNotificationTaskData() {
    final querySnapshot = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuthUtills.uid)
        .collection('notificationTask')
        .orderBy('createdAt', descending: true);

    return querySnapshot;
  }

  static Future<void> deleteTaskData(doc) async {
    final document = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuthUtills.uid)
        .collection('notificationTask')
        .where('notificationTask', isEqualTo: doc)
        .get();
    for (var doc in document.docs) {
      doc.reference.delete();
    }
  }
}
