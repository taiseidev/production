import 'package:flutter/material.dart';
import 'package:myproduction/notificationApp/view/setting_page.dart';

import 'home_page.dart';
import 'post_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;

  void changeBottomNavigation(int i) {
    setState(() {
      _currentPageIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xff58BBD2),
      automaticallyImplyLeading: false,
      title: const Text(
        'タスクタイマー',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildBody() {
    if (_currentPageIndex == 0) {
      return HomePage();
    } else if (_currentPageIndex == 1) {
      return PostPage();
    }
    return const SettingPage();
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: '一覧',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '設定',
          ),
        ],
        selectedItemColor: const Color(0xff58BBD2),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        currentIndex: _currentPageIndex,
        onTap: (i) => changeBottomNavigation(i));
  }
}
