import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myproduction/notificationApp/repository/firestore_repository.dart';
import 'package:myproduction/notificationApp/state/task_state.dart';
import 'package:http/http.dart' as http; // これを書かないとライブラリをコールできません

class TaskViewModel extends StateNotifier<TaskState> {
  TaskViewModel() : super(const TaskState());

  final functions = FirebaseFunctions.instance;

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

  // Future<void> requestAPI(BuildContext context) async {
  //   HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
  //       'functionsTest',
  //       options: HttpsCallableOptions(timeout: const Duration(seconds: 300)));
  //   await callable();
  // }
}
