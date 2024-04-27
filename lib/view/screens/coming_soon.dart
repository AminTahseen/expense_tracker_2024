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
              Icons.construction,
              size: 100,
              color: MAIN_APP_COLOR_DARK,
            ),
            const AddSpacing(),
            Text(
              "Coming Soon",
              style: GoogleFonts.lato(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "This feature is in development",
              style: GoogleFonts.lato(
                fontSize: 14,
                letterSpacing: 2,
              ),
            ),
            const AddSpacing(),
            const AddSpacing(),
            Container(
              padding: const EdgeInsets.only(bottom: 10, left: 50, right: 50),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MAIN_APP_COLOR_DARK,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => AppNavigator().onNavigatorPop(context),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Take Me Back".toUpperCase(),
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
