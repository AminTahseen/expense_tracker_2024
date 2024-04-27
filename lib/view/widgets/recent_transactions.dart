import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/model/transaction_model.dart';
import 'package:expense_tracker_2024/view/widgets/no_data_available.dart';
import 'package:expense_tracker_2024/viewModel/transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'transaction_item.dart';

class RecentTransactions extends StatelessWidget {
  final TransactionViewModel transactionViewModel;
  const RecentTransactions({super.key, required this.transactionViewModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Transactions",
            style: GoogleFonts.lato(
                fontWeight: FontWeight.bold, color: TEXT_GREY_DARK),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 10.0,
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 35.0,
              maxHeight: 180.0,
            ),
            child: Scrollbar(
              trackVisibility: true,
              child: ValueListenableBuilder<Box<TransactionModel>>(
                valueListenable:
                    transactionViewModel.getTransactions().listenable(),
                builder: (context, box, _) {
                  var data2 = box.values.toList().cast<TransactionModel>();
                  var data = data2.reversed.toList().cast<TransactionModel>();
                  return data.isNotEmpty
                      ? ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              const Divider(height: 1, color: Colors.black12),
                          itemCount: box.length,
                          itemBuilder: (context, index) {
                            return TransactionItem(
                              category: data[index].categoryName,
                              amount: data[index].amount,
                              icon: Icons.currency_exchange_rounded,
                              type: data[index].transactionType,
                              accountName: data[index].accountName,
                            );
                          },
                        )
                      : const NoDataAvailable(message: "No Transactions Yet");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
