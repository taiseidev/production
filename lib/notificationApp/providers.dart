import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myproduction/notificationApp/model/count_model.dart';
import 'package:myproduction/notificationApp/model/notification_task_model.dart';
import 'package:myproduction/notificationApp/repository/firestore_repository.dart';
import 'package:myproduction/notificationApp/viewModel/notification_task_view_model.dart';
import 'package:myproduction/notificationApp/viewModel/task_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/task_model.dart';
import 'state/task_state.dart';
import 'viewModel/count_view_model.dart';

final taskViewModelProvider =
    StateNotifierProvider.autoDispose<TaskViewModel, TaskState>(
        (ref) => TaskViewModel());

final countViewModelProvider =
    StateNotifierProvider<CountViewModel, CountModel>(
  (ref) => CountViewModel(ref),
);

final notificationTaskViewModelProvider =
    StateNotifierProvider.autoDispose<NotificationTaskViewModel, TaskState>(
        (ref) => NotificationTaskViewModel());

// タスク追加画面のタスク一覧をStreamで取得
final itemsStreamProvider = StreamProvider<List<TaskModel>>((ref) {
  // taskドキュメントのスナップショットを取得
  final collection = FirestoreRepository.getTaskData();
  // データ（Map型）を取得
  final stream = collection.snapshots().map(
        (e) => e.docs
            .map(
              (e) => TaskModel.fromJson(
                e.data(),
              ),
            )
            .toList(),
      );
  return stream;
});

// 通知予定のタスク一覧を取得
final notificationTaskProvider =
    StreamProvider<List<NotificationTaskModel>>((ref) {
  // タスクドキュメントのスナップショットを取得
  final collection = FirestoreRepository.getNotificationTaskData();
  // データ（Map型）を取得
  final stream = collection.snapshots().map(
        (e) => e.docs
            .map(
              (e) => NotificationTaskModel.fromJson(
                e.data(),
              ),
            )
            .toList(),
      );

  return stream;
});
