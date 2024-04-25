import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/view/screens/charts.dart';
import 'package:expense_tracker_2024/view/screens/home.dart';
import 'package:expense_tracker_2024/view/screens/history.dart';
import 'package:expense_tracker_2024/view/screens/settings.dart';
import 'package:flutter/material.dart';

class BottomNavigationHolder extends StatefulWidget {
  const BottomNavigationHolder({super.key});

  @override
  State<BottomNavigationHolder> createState() => _BottomNavigationHolderState();
}

class _BottomNavigationHolderState extends State<BottomNavigationHolder> {
  int _selectedTab = 0;

  final List _pages = [
    const HomeScreen(),
    const HistoryScreen(),
    const ChartsScreen(),
    const SettingsScreen()
  ];
  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedTab],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        indicatorColor: MAIN_APP_COLOR_DARK_LIGHT,
        selectedIndex: _selectedTab,
        onDestinationSelected: (index) => _changeTab(index),
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_filled),
            label: "Home",
            selectedIcon: Icon(
              Icons.home_filled,
              color: Colors.white,
            ),
          ),
          NavigationDestination(
              icon: Icon(Icons.timelapse),
              label: "History",
              selectedIcon: Icon(
                Icons.timelapse,
                color: Colors.white,
              )),
          NavigationDestination(
              icon: Icon(
                Icons.bar_chart,
              ),
              label: "Statistics",
              selectedIcon: Icon(
                Icons.bar_chart,
                color: Colors.white,
              )),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: "Settings",
            selectedIcon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
