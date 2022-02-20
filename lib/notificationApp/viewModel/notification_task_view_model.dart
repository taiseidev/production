import 'dart:async';

import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myproduction/notificationApp/repository/firestore_repository.dart';
import 'package:myproduction/notificationApp/state/task_state.dart';

class NotificationTaskViewModel extends StateNotifier<TaskState> {
  NotificationTaskViewModel() : super(const TaskState()) {}

  Future<void> deleteNotificationTask(String text) async {
    state = state.copyWith(isLoading: true);
    try {
      await FirestoreRepository.deleteTaskData(text);
    } catch (e) {
      print('エラー：${e.toString()}');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
