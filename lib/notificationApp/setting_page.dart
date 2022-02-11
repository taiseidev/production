import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
    _getUserInfo();
    super.initState();
    setItems();
    _selectItem = _items[0].value!;
  }

  List userInfoList = [];
  List<DropdownMenuItem<int>> _items = [];
  int _selectItem = 0;

  Future<void> _getUserInfo() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final userInfo =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    userInfo.data()!.forEach((key, value) {
      userInfoList.add(value);
    });
  }

  void setItems() {
    _items
      ..add(DropdownMenuItem(
        child: Text(
          'A',
          style: TextStyle(fontSize: 40.0),
        ),
        value: 1,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          'B',
          style: TextStyle(fontSize: 40.0),
        ),
        value: 2,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          'C',
          style: TextStyle(fontSize: 40.0),
        ),
        value: 3,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton(
          items: _items,
          value: _selectItem,
          onChanged: (value) => {
            setState(() {
              _selectItem = value as int;
            }),
          },
        ),
      ],
    );
  }
}
