import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionItem extends StatelessWidget {
  final IconData icon;
  final String category;
  final double amount;
  final int type;
  final String accountName;
  final String date;
  const TransactionItem({
    super.key,
    required this.category,
    required this.amount,
    required this.icon,
    required this.type,
    required this.accountName,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 237, 235, 235),
        child: Icon(
          icon,
          color: MAIN_APP_COLOR_DARK,
        ),
      ),
      title: Text(
        category.capitalize(),
        style: GoogleFonts.lato(
            fontSize: 16, fontWeight: FontWeight.bold, color: MAIN_APP_COLOR),
      ),
      subtitle: type == 0
          ? _subtitleSection(
              '${numToCurrency(amount, '0')} deducted from $accountName',
              date,
            )
          : _subtitleSection(
              '${numToCurrency(amount, '0')} added in $accountName',
              date,
            ),
      trailing: type == 0
          ? const Icon(
              Icons.arrow_upward_outlined,
              color: Colors.red,
            )
          : const Icon(
              Icons.arrow_downward_outlined,
              color: Colors.green,
            ),
    );
  }
}

//
Column _subtitleSection(String text1, String date) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text1,
        style: GoogleFonts.lato(
          fontStyle: FontStyle.italic,
          color: TEXT_GREY_DARK,
        ),
      ),
      Text(
        convertDateToReadable(date),
        style: GoogleFonts.lato(
          color: TEXT_GREY_DARK,
          fontWeight: FontWeight.bold,
        ),
      )
    ],
  );
}
