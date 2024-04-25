import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseIncomeBox extends StatelessWidget {
  final String data;
  final String amount;
  final Widget icon;
  final int transactionType;

  const ExpenseIncomeBox({
    super.key,
    required this.data,
    required this.amount,
    required this.icon,
    required this.transactionType,
  });

  @override
  Widget build(BuildContext context) {
    var size, width;
    size = MediaQuery.of(context).size;
    width = size.width;
    return Expanded(
      child: SizedBox(
        width: width * 0.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 176, 175, 175),
              child: icon,
            ),
            SizedBox(
              width: width * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data,
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    amount,
                    style: GoogleFonts.lato(
                      color: transactionType == 0 ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
