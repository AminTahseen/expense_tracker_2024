import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountSelection extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final IconData icon;
  final String accountName;
  final void Function(int) getSelectedIndex;

  const AccountSelection(
      {super.key,
      required this.index,
      required this.selectedIndex,
      required this.accountName,
      required this.icon,
      required this.getSelectedIndex});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getSelectedIndex(index);
      },
      child: Column(
        children: [
          index == selectedIndex
              ? Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 3, color: MAIN_APP_COLOR_DARK),
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: APP_BG_WHITE,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Icon(
                      icon,
                      color: MAIN_APP_COLOR_DARK,
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: APP_BG_WHITE,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Icon(
                      icon,
                      color: MAIN_APP_COLOR,
                    ),
                  ),
                ),
          index == selectedIndex
              ? Text(
                  overflow: TextOverflow.ellipsis,
                  accountName,
                  style: GoogleFonts.lato(
                    fontSize: 12,
                    color: MAIN_APP_COLOR_DARK,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Text(
                  overflow: TextOverflow.ellipsis,
                  accountName,
                  style: GoogleFonts.lato(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
        ],
      ),
    );
  }
}
