import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproduction/notificationApp/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationApp extends StatelessWidget {
  const NotificationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TopScreen();
  }
}

class TopScreen extends StatefulWidget {
  const TopScreen({Key? key}) : super(key: key);

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  final firebaseauth = FirebaseAuth.instance;
  Future<void> _onSignInWithAnonymousUser() async {
    try {
      await firebaseauth.signInAnonymously();
      await _setUserId();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ));
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('エラー'),
            content: Text(e.toString()),
          );
        },
      );
    }
  }

  Future<void> _setUserId() async {
    // 「始める」ボタンを押したときの時刻を取得
    final now = DateTime.now();
    // 匿名認証を利用しているユーザーのユーザーIDを取得
    final uid = firebaseauth.currentUser!.uid; // nullableの可能性あり
    // firestoreにユーザー情報を追加
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'userId': uid,
      'createdAt': now,
    });
    // 匿名認証でログインできるようにローカルにユーザーIDを保存
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _onSignInWithAnonymousUser,
              child: const Text('始める'),
            ),
          ],
        ),
      ),
    );
  }
}
