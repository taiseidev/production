import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers.dart';

class PostPage extends ConsumerWidget {
  DateTime now = DateTime.now();
  final _notificationTime = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemsStreamProvider);
    return Scaffold(
      body: items.when(
        data: (items) {
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final item = items[index];
              return GestureDetector(
                onLongPress: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (_) {
                  //     return AlertDialog(
                  //       title: Text(
                  //         "_notificationTime.textdata.docs[index]['task']を通知しますか？",
                  //         style: const TextStyle(fontWeight: FontWeight.bold),
                  //       ),
                  //       content: Padding(
                  //         padding: const EdgeInsets.only(right: 200.0),
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             border: Border.all(
                  //               color: const Color(0xffC2C2C3),
                  //             ),
                  //           ),
                  //           child: Padding(
                  //             padding: const EdgeInsets.only(
                  //               right: 8.0,
                  //               left: 8.0,
                  //             ),
                  //             child: TextFormField(
                  //               controller: _notificationTime,
                  //               keyboardType: TextInputType.number, // 数値のみ入力を許容
                  //               decoration: const InputDecoration(
                  //                 border: InputBorder.none,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       actions: <Widget>[
                  //         // ボタン領域
                  //         ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //             primary: const Color(0xff58BBD2),
                  //           ),
                  //           child: const Text("閉じる"),
                  //           onPressed: () => Navigator.pop(context),
                  //         ),
                  //         ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //             primary: const Color(0xff58BBD2),
                  //           ),
                  //           child: const Text("追加"),
                  //           onPressed: () async {
                  //             // setNotificationTask(data.docs[index]['task']);
                  //             Navigator.pop(context);
                  //           },
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // );
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
        error: (error, stack) => Text('Error: $error'),
        loading: () => const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff58BBD2),
        child: const Icon(Icons.add),
        onPressed: () {
          _buildDialog(context);
        },
      ),
    );
  }

  Future _buildDialog(BuildContext context) {
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
                // await setTask(controller.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
