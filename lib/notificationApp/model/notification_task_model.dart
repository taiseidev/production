import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'notification_task_model.freezed.dart';
part 'notification_task_model.g.dart';

@freezed
class NotificationTaskModel with _$NotificationTaskModel {
  const factory NotificationTaskModel({
    required String notificationTask,
    required int notificationTime,
  }) = _NotificationTaskModel;

  factory NotificationTaskModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationTaskModelFromJson(json);

  factory NotificationTaskModel.fromSnapshot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      NotificationTaskModel.fromJson(snapshot.data()!);
}
