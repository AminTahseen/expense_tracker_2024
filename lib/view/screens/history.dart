import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/model/transaction_model.dart';
import 'package:expense_tracker_2024/navigator/navigator.dart';
import 'package:expense_tracker_2024/view/screens/add_edit_transaction.dart';
import 'package:expense_tracker_2024/view/widgets/history_section.dart';
import 'package:expense_tracker_2024/view/widgets/search_bar.dart';
import 'package:expense_tracker_2024/view/widgets/spacing.dart';
import 'package:expense_tracker_2024/viewModel/transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool showSearchBar = false;
  _showHideSearchBar() {
    setState(() {
      showSearchBar = !showSearchBar;
    });
  }

  @override
  Widget build(BuildContext context) {
    TransactionViewModel transactionViewModel =
        context.watch<TransactionViewModel>();
    return Scaffold(
      backgroundColor: APP_BG_WHITE,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(color: MAIN_APP_COLOR),
              padding: const EdgeInsets.only(
                  top: 50.0, left: 20, right: 20, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "History",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      FloatingActionButton.small(
                        heroTag: "Search Button",
                        elevation: 2,
                        shape: const CircleBorder(),
                        onPressed: () => _showHideSearchBar(),
                        backgroundColor: Colors.white,
                        child: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                      FloatingActionButton.small(
                        heroTag: "Transaction Button",
                        elevation: 2,
                        shape: const CircleBorder(),
                        onPressed: () {
                          AppNavigator.onNavigatePush(
                            context,
                            const AddEditTransaction(),
                          );
                        },
                        backgroundColor: MAIN_APP_COLOR_DARK,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            if (showSearchBar) const AppSearchBar(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ValueListenableBuilder<Box<TransactionModel>>(
                valueListenable:
                    transactionViewModel.getTransactions().listenable(),
                builder: (context, box, _) {
                  DateTime currentDate = DateTime.now();
                  var formatter = DateFormat('yyyy-MM-dd');
                  String formattedDate = formatter.format(currentDate);
                  var data = box.values
                      .where((transaction) =>
                          transaction.createdOn == formattedDate)
                      .toList()
                      .cast<TransactionModel>();
                  return HistorySection(
                    historyTitle: "Today",
                    data: data,
                  );
                },
              ),
            ),
            const AddSpacing(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ValueListenableBuilder<Box<TransactionModel>>(
                valueListenable:
                    transactionViewModel.getTransactions().listenable(),
                builder: (context, box, _) {
                  DateTime yesterday =
                      DateTime.now().subtract(const Duration(days: 1));
                  var formatter = DateFormat('yyyy-MM-dd');
                  String formattedDate = formatter.format(yesterday);
                  var data = box.values
                      .where((transaction) =>
                          transaction.createdOn == formattedDate)
                      .toList()
                      .cast<TransactionModel>();
                  return HistorySection(
                    historyTitle: "Yesterday",
                    data: data,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
