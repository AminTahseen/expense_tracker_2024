import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/constants/data.dart';
import 'package:expense_tracker_2024/model/transaction_model.dart';
import 'package:expense_tracker_2024/view/widgets/no_data_available.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

import 'transaction_item.dart';

class HistorySection extends StatelessWidget {
  final String historyTitle;
  final List<TransactionModel> data;

  const HistorySection(
      {super.key, required this.historyTitle, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text(
            historyTitle,
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: TEXT_GREY_DARK,
            ),
          ),
        ),
        data.isNotEmpty
            ? ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 35.0,
                  maxHeight: 200.0,
                ),
                child: Scrollbar(
                  trackVisibility: true,
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, color: Colors.black12),
                    padding: const EdgeInsets.all(0.0),
                    // Let the ListView know how many items it needs to build.
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return TransactionItem(
                        category: data[index].accountName,
                        amount: data[index].amount,
                        icon: Icons.currency_exchange_rounded,
                        type: data[index].transactionType,
                        accountName: data[index].accountName,
                      );
                    },
                  ),
                ),
              )
            : const NoDataAvailable(message: "No Transaction Yet")
      ],
    );
  }
}
