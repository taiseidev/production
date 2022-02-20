import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcm_config/fcm_config.dart';
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
    return Scaffold(
      body: FCMNotificationListener(
        onNotification: (RemoteMessage notification, _) async {},
        child: Center(
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: SizedBox(
                                child: Text(
                                  item.count.toString(),
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
      ),
    );
  }

  // Future<void> dialog(BuildContext context, RemoteMessage notification) {
  //   return showDialog(
  //     context: context,
  //     builder: (_) {
  //       return AlertDialog(
  //         title: Text("${notification.notification!.title}"),
  //         content: Text("${notification.notification!.body}"),
  //         actions: <Widget>[
  //           // ボタン領域
  //           TextButton(
  //             child: Text("Cancel"),
  //             onPressed: () => Navigator.pop(context),
  //           ),
  //           TextButton(
  //             child: Text("OK"),
  //             onPressed: () => Navigator.pop(context),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
