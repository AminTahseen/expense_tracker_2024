import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/navigator/navigator.dart';
import 'package:expense_tracker_2024/view/screens/coming_soon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuClick;

  const ExpenseAppBar({super.key, required this.onMenuClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: MAIN_APP_COLOR),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onMenuClick,
            child: const Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Icon(
                Icons.sort_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Home",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => AppNavigator().onNavigatePush(
              context,
              const ComingSoonScreen(),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
              child: Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
