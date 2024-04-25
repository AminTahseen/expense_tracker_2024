import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItem extends StatelessWidget {
  final String categoryId;
  final IconData icon;
  final String categoryName;
  const CategoryItem({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: MAIN_APP_COLOR_DARK,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          title: Text(
            categoryName.capitalize(),
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: MAIN_APP_COLOR,
            ),
          ),
        ),
      ),
    );
  }
}
