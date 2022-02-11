import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  DateTime now = DateTime.now();
  DateFormat outputFormat = DateFormat('yyyy-MM-dd H' + ':' + 'm');
  List userInfo = [];
  final _notificationTime = TextEditingController();

  Future<void> setTask(String task) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('task')
        .add(
      {
        'task': task,
        'createdAt': outputFormat.format(now),
      },
    );
    getTaskData();
  }

  Future getTaskData() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('task')
        .orderBy('createdAt', descending: true)
        .get();
    querySnapshot.docs.map((e) {
      return userInfo.add(e['task']);
    }).toList();
  }

  Future setNotificationTask(String task) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('notificationTask')
        .add({
      'notificationTask': task,
      'notificationTime': int.parse(_notificationTime.text),
      'createdAt': DateTime.now(),
    });
  }

  @override
  void initState() {
    super.initState();
    getTaskData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('task')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xff58BBD2),
                ),
              );
            }
            final data = snapshot.data;
            return ListView.builder(
              itemCount: data!.size,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text(
                            "${_notificationTime.text}${data.docs[index]['task']}を通知しますか？",
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
                                  controller: _notificationTime,
                                  keyboardType:
                                      TextInputType.number, // 数値のみ入力を許容
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
                                setNotificationTask(data.docs[index]['task']);
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
                        data.docs[index]['task'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        data.docs[index]['createdAt'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
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
                await setTask(controller.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
