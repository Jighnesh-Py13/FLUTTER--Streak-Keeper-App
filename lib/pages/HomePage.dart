import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:streak_keeper/pages/today_page.dart';
import 'package:streak_keeper/pages/progress_page.dart';
import 'package:streak_keeper/pages/journey_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final myBox = Hive.box("mybox");

  late int _selectedIndex;

  final List<Widget> _pages = const [
    TodayPage(),
    ProgressPage(),
    JourneyPage(),
  ];


  @override
  void initState() {
    super.initState();

    var goals = myBox.get("GOALLIST");

    if (goals == null || goals.isEmpty) {
      // No goals yet -> open Journey page
      _selectedIndex = 2;
    } else {
      // Goals available -> open Today page
      _selectedIndex = 0;
    }
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: "Today",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department),
            label: "Progress",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Journey",
          ),
        ],
      ),
    );
  }
}