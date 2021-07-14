import 'package:directwp/screens/about.dart';
import 'package:directwp/screens/help.dart';
import 'package:directwp/screens/history.dart';
import 'package:directwp/screens/home.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  // Handle Bottom Navigation Change
  void _handleNavigationChange(int index) {
    switch (index) {
      case 1:
        Navigator.pushNamed(context, HistoryScreen.routeName);
        break;
      case 2:
        Navigator.pushNamed(context, HelpScreen.routeName);
        break;
      default:
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'History'),
        BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Help'),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.teal[500],
      onTap: _handleNavigationChange,
    );
  }
}
