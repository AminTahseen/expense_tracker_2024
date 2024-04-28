import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/navigator/navigator.dart';
import 'package:expense_tracker_2024/view/screens/add_edit_transaction.dart';
import 'package:expense_tracker_2024/view/screens/coming_soon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            MAIN_APP_COLOR_DARK,
            MAIN_APP_COLOR_DARK_DIFF,
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          QuickActionItem(
            content: "Transaction",
            icon: const Icon(
              Icons.add_circle_outline_outlined,
              size: 30,
              color: Colors.black,
            ),
            onTapClick: () {
              AppNavigator.onNavigatePush(
                context,
                const AddEditTransaction(),
              );
            },
          ),
          QuickActionItem(
            content: "Reminder",
            icon: const Icon(
              Icons.alarm_add_outlined,
              size: 30,
              color: Colors.black,
            ),
            onTapClick: () {
              AppNavigator.onNavigatePush(
                context,
                const ComingSoonScreen(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class QuickActionItem extends StatelessWidget {
  final String content;
  final Widget icon;
  final VoidCallback onTapClick;

  const QuickActionItem({
    super.key,
    required this.content,
    required this.icon,
    required this.onTapClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapClick,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            icon,
            Text(
              content,
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
