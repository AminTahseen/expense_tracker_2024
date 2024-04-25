import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionType extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final String type;
  final void Function() selectedType;

  const TransactionType({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.type,
    required this.selectedType,
  });

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? GestureDetector(
            onTap: () => selectedType(),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                  border: Border.all(width: 5, color: MAIN_APP_COLOR_DARK),
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(2),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Icon(
                      icon,
                      color: MAIN_APP_COLOR_DARK,
                      size: 40,
                    ),
                    Text(
                      type,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        color: MAIN_APP_COLOR_DARK,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () => selectedType(),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.black),
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(2),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Icon(
                      icon,
                      color: Colors.black,
                      size: 40,
                    ),
                    Text(
                      type,
                      style: GoogleFonts.lato(color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
