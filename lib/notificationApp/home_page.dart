import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import 'config/config_alert.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _alarm = Alarm();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  String test = '';

  Future<void> deleteTaskData(doc) async {
    final document = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('notificationTask')
        .where('notificationTask', isEqualTo: doc)
        .get();
    for (var doc in document.docs) {
      doc.reference.delete();
    }
  }

  Timer? _timer;
  late DateTime _time;

  @override
  void initState() {
    super.initState();
    _time = DateTime.utc(0, 0, 1);
  }

  @override
  Widget build(BuildContext context) {
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
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .collection('notificationTask')
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
                          return Slidable(
                            endActionPane: ActionPane(
                              extentRatio: 0.2,
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (BuildContext context) {
                                    deleteTaskData(
                                      data.docs[index]['notificationTask'],
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
                                  data.docs[index]['notificationTask'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: SizedBox(
                                  child: Text(
                                    DateFormat.Hms().format(_time),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                trailing: Text(
                                  '${data.docs[index]['notificationTime']}時間後に設定'
                                      .toString(),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
              )
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: '1',
              onPressed: () {
                _timer = Timer.periodic(
                  const Duration(seconds: 1),
                  (Timer timer) {
                    setState(() {
                      _time = _time.add(const Duration(seconds: 1));
                    });
                  },
                );
              },
              child: const Text("Start"),
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              heroTag: 2,
              onPressed: () {
                _alarm.alertStart();
              },
              child: const Text("Alert"),
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              heroTag: '3',
              onPressed: () {
                _alarm.alertStop();
              },
              child: Text('Stop'),
            )
          ],
        ));
  }
}
