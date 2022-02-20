import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myproduction/notificationApp/model/count_model.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class CountViewModel extends StateNotifier<CountModel> {
  CountViewModel(StateNotifierProviderRef<CountViewModel, CountModel> ref)
      : super(const CountModel());

  late DateTime _time;

  void setTimer() {
    try {
      state = state.copyWith(countTimer: 0);
      increment();
    } catch (e) {}
  }

  void increment() {
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        state = state.copyWith(countTimer: state.countTimer + 1);
      },
    );
  }
}
