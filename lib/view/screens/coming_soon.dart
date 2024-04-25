import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/navigator/navigator.dart';
import 'package:expense_tracker_2024/view/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_BG_WHITE,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_emotions_outlined,
              size: 100,
              color: MAIN_APP_COLOR_DARK,
            ),
            Text(
              "Coming Soon",
              style:
                  GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              "This feature is in development",
              style: GoogleFonts.lato(
                fontSize: 20,
              ),
            ),
            const AddSpacing(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MAIN_APP_COLOR_DARK,
              ),
              onPressed: () => AppNavigator().onNavigatorPop(context),
              child: Text(
                "Go Back",
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
