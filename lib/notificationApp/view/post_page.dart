import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myproduction/notificationApp/repository/firestore_repository.dart';
import 'package:myproduction/notificationApp/viewModel/task_view_model.dart';

import '../providers.dart';

class PostPage extends ConsumerWidget {
  final notificationTime = TextEditingController();

  PostPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemsStreamProvider);
    final notifier = ref.watch(taskViewModelProvider.notifier);
    return Scaffold(
      body: items.when(
        data: (items) {
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final item = items[index];
              return GestureDetector(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text(
                          "${item.task}を通知しますか？",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: Padding(
                          padding: const EdgeInsets.only(right: 200.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xffC2C2C3),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 8.0,
                                left: 8.0,
                              ),
                              child: TextFormField(
                                controller: notificationTime,
                                keyboardType: TextInputType.number, // 数値のみ入力を許容
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          // ボタン領域
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xff58BBD2),
                            ),
                            child: const Text("閉じる"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xff58BBD2),
                            ),
                            child: const Text("追加"),
                            onPressed: () async {
                              notifier.setNotificationTaskData(
                                item.task,
                                notificationTime,
                              );
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text(
                      item.task,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      item.createdAt,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
        loading: () => const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff58BBD2),
        child: const Icon(Icons.add),
        onPressed: () {
          _buildDialog(context, notifier);
        },
      ),
    );
  }

  Future _buildDialog(BuildContext context, TaskViewModel notifier) {
    final controller = TextEditingController();
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            "タスクを追加",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xffC2C2C3),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                  left: 8.0,
                ),
                child: TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            // ボタン領域
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff58BBD2),
              ),
              child: const Text(
                "閉じる",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff58BBD2),
              ),
              child: const Text(
                "追加",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                await notifier.setTaskData(controller.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
