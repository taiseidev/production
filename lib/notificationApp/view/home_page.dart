import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myproduction/notificationApp/config/config_alert.dart';
import 'package:myproduction/notificationApp/utils/firestore_auth.dart';

import '../providers.dart';

class HomePage extends ConsumerWidget {
  final _alarm = Alarm();

  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationTaskViewModelProvider);
    final notifier = ref.watch(notificationTaskViewModelProvider.notifier);
    final items = ref.watch(notificationTaskProvider);
    final countNotifier = ref.watch(countViewModelProvider.notifier);
    final count = ref.watch(countViewModelProvider);

    ref.listen(
      countViewModelProvider,
      (previous, state) {
        if (state == 10) {
          showDialog<void>(
            context: context,
            builder: (_) => SimpleDialog(
              title: Text("タイトル"),
              children: <Widget>[
                // コンテンツ領域
                SimpleDialogOption(
                  onPressed: () => Navigator.pop(context),
                  child: Text("１項目目"),
                ),
              ],
            ),
          );
        }
      },
    );
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(40.0),
              child: Text(
                '実行中',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: items.when(
                data: (items) {
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = items[index];
                      return Slidable(
                        endActionPane: ActionPane(
                          extentRatio: 0.2,
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (BuildContext context) {
                                notifier.deleteNotificationTask(
                                  item.notificationTask,
                                );
                              },
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: '削除',
                            ),
                          ],
                        ),
                        child: Card(
                          child: ListTile(
                            title: Text(
                              item.notificationTask,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: SizedBox(
                              child: Text(
                                count.countTimer.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            trailing: Text(
                              '${item.notificationTime}時間後に設定'.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff58BBD2),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                error: (error, stack) => Center(
                  child: Text(
                    '通知予定のタスクを取得できませんでした。\n${error.toString()}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                loading: () => const CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //       heroTag: '1',
      //       onPressed: () {
      //         notifier.changeTimer();
      //       },
      //       child: const Text("Start"),
      //     ),
      //     SizedBox(
      //       height: 10,
      //     ),
      //     FloatingActionButton(
      //       heroTag: 2,
      //       onPressed: () {
      //         _alarm.alertStart();
      //       },
      //       child: const Text("Alert"),
      //     ),
      //     SizedBox(
      //       height: 10,
      //     ),
      //     FloatingActionButton(
      //       heroTag: '3',
      //       onPressed: () {
      //         _alarm.alertStop();
      //       },
      //       child: Text('Stop'),
      //     )
      //   ],
      // ),
    );
  }
}
