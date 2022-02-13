import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'count_model.freezed.dart';

@freezed
class CountModel with _$CountModel {
  const factory CountModel({
    @Default(0) int countTimer, // 各タスクの経過時間を表示
  }) = _CountModel;
}
