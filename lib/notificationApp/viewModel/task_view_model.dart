import 'package:flutter/src/widgets/editable_text.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myproduction/notificationApp/repository/firestore_repository.dart';
import 'package:myproduction/notificationApp/state/task_state.dart';

class TaskViewModel extends StateNotifier<TaskState> {
  TaskViewModel() : super(const TaskState());

  Future<void> setTaskData(String text) async {
    state = state.copyWith(isLoading: true);
    try {
      await FirestoreRepository.setTask(text);
    } catch (e) {
      print('エラー：${e.toString()}');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> setNotificationTaskData(
      String text, TextEditingController notificationTime) async {
    state = state.copyWith(isLoading: true);
    await FirestoreRepository.setNotificationTask(text, notificationTime);
    try {} catch (e) {
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
