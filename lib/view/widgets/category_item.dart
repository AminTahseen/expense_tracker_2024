import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItem extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  const CategoryItem({
    super.key,
    required this.categoryId,
    required this.categoryName,
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
            radius: 16,
            backgroundColor: MAIN_APP_COLOR_DARK,
            child: const Icon(
              Icons.category,
              color: Colors.white,
              size: 20,
            ),
          ),
          title: Text(
            categoryName,
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: MAIN_APP_COLOR,
            ),
          ),
        ),
      ),
    );
  }
}
