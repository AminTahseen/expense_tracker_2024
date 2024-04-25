import 'package:expense_tracker_2024/view/screens/bottom_navigation.dart';
import 'package:expense_tracker_2024/view/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class ZoomDrawerScreen extends StatefulWidget {
  const ZoomDrawerScreen({super.key});

  @override
  State<ZoomDrawerScreen> createState() => _ZoomDrawerScreenState();
}

class _ZoomDrawerScreenState extends State<ZoomDrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return const ZoomDrawer(
      mainScreenTapClose: true,
      menuScreen: AppNavigationDrawer(),
      mainScreen: BottomNavigationHolder(),
      showShadow: true,
      style: DrawerStyle.defaultStyle,
      reverseDuration: Duration.zero,
      angle: 0.0,
      androidCloseOnBackTap: true,
    );
  }
}
