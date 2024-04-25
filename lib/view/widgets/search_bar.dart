import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        style: GoogleFonts.lato(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          fillColor: Colors.grey.shade300,
          filled: true,
          hintText: "Search",
          prefixIcon: Icon(
            Icons.search,
            color: MAIN_APP_COLOR,
          ),
        ),
      ),
    );
  }
}
