import 'package:directwp/screens/history.dart';
import 'package:directwp/screens/home.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  static final routeName = "/";

  const TabScreen({Key key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;
  List<Map<String, Object>> _pages;

  @override
  void initState() {
    // TODO: implement initState
    _pages = [
      {'title': 'Direct Chat', 'page': MyHomePage()},
      {'title': 'History', 'page': HistoryScreen()},
    ];
    super.initState();
  }

  // Handle Bottom Navigation Change
  void _handleNavigationChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.format_list_bulleted_rounded,
              ),
              label: 'History'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal[500],
        onTap: _handleNavigationChange,
      ),
    );
  }
}
