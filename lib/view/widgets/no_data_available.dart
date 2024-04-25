import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoDataAvailable extends StatelessWidget {
  final String message;
  const NoDataAvailable({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 60,
              color: MAIN_APP_COLOR_DARK,
            ),
            Text(
              message,
              style: GoogleFonts.lato(
                color: TEXT_GREY_DARK,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
