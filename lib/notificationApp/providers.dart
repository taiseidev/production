import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myproduction/notificationApp/viewModel/task_view_model.dart';

import 'model/task_model.dart';
import 'state/task_state.dart';

final taskViewModelProvider =
    StateNotifierProvider.autoDispose<TaskViewModel, TaskState>(
        (ref) => TaskViewModel());

final itemsStreamProvider = StreamProvider<List<TaskModel>>((ref) {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  // taskドキュメントのスナップショットを取得
  final collection = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('task')
      .orderBy('createdAt', descending: true);

  // データ（Map型）を取得
  final stream = collection.snapshots().map(
        (e) => e.docs.map((e) => TaskModel.fromJson(e.data())).toList(),
      );
  return stream;
});
