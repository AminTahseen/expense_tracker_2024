import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountItem extends StatelessWidget {
  final String accountId;
  final IconData icon;
  final String category;
  final double amount;
  const AccountItem({
    super.key,
    required this.accountId,
    required this.category,
    required this.amount,
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
            radius: 16,
            backgroundColor: MAIN_APP_COLOR_DARK,
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          title: Text(
            category,
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: MAIN_APP_COLOR,
            ),
          ),
          trailing: Text(
            numToCurrency(amount, '0'),
            style: GoogleFonts.lato(
              color: TEXT_GREY_DARK,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
