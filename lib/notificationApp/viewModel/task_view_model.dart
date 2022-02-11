import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myproduction/notificationApp/state/task_state.dart';
import 'package:intl/intl.dart';

class TaskViewModel extends StateNotifier<TaskState> {
  TaskViewModel() : super(const TaskState()) {
    getTaskData();
  }
  final uid = FirebaseAuth.instance.currentUser!.uid;
  DateFormat outputFormat = DateFormat('yyyy-MM-dd H' + ':' + 'm');
  List userInfo = [];

  Future getTaskData() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('task')
        .orderBy('createdAt', descending: true)
        .get();
    querySnapshot.docs.map((e) {
      return userInfo.add(e['task']);
    }).toList();
  }

  Future<void> setTask(String task) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('task')
        .add(
      {
        'task': task,
        'createdAt': outputFormat.format(now),
      },
    );
    getTaskData();
  }

  Future setNotificationTask(String task) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('notificationTask')
        .add({
      'notificationTask': task,
      'notificationTime': int.parse(_notificationTime.text),
      'createdAt': DateTime.now(),
    });
  }
}
