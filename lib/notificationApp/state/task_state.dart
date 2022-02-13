import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myproduction/notificationApp/model/notification_task_model.dart';
import 'package:myproduction/notificationApp/model/task_model.dart';

part 'task_state.freezed.dart';

@freezed
class TaskState with _$TaskState {
  const factory TaskState({
    @Default(false) bool isLoading,
    @Default(false) bool isReadyData,
    @Default(<TaskModel>[]) List<TaskModel> taskModel,
    @Default(<NotificationTaskModel>[])
        List<NotificationTaskModel> notificationTaskModel,
  }) = _TaskState;
}
