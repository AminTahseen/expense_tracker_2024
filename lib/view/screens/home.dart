import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/helpers/helpers.dart';
import 'package:expense_tracker_2024/model/accounts_model.dart';
import 'package:expense_tracker_2024/model/transaction_model.dart';
import 'package:expense_tracker_2024/view/widgets/app_bar.dart';
import 'package:expense_tracker_2024/view/widgets/expense_income_box.dart';
import 'package:expense_tracker_2024/view/widgets/quick_actions.dart';
import 'package:expense_tracker_2024/view/widgets/recent_transactions.dart';
import 'package:expense_tracker_2024/view/widgets/spacing.dart';
import 'package:expense_tracker_2024/view/widgets/total_balance_box.dart';
import 'package:expense_tracker_2024/viewModel/accounts_view_model.dart';
import 'package:expense_tracker_2024/viewModel/transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    TransactionViewModel transactionViewModel =
        context.watch<TransactionViewModel>();
    AccountsViewModel accountsViewModel = context.watch<AccountsViewModel>();
    var size, width;
    size = MediaQuery.of(context).size;
    width = size.width;
    return Scaffold(
      backgroundColor: APP_BG_WHITE,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ExpenseAppBar(
            onMenuClick: () => {
              if (ZoomDrawer.of(context)!.isOpen())
                {ZoomDrawer.of(context)!.close()}
              else
                {ZoomDrawer.of(context)!.open()}
            },
          ),
          const AddSpacing(),
          ValueListenableBuilder<Box<AccountsModel>>(
            valueListenable: accountsViewModel.getAccounts().listenable(),
            builder: (context, box, _) {
              var data = box.values.toList().cast<AccountsModel>();
              double sum = data
                  .map((transaction) => transaction.openingBalance)
                  .fold(0, (previous, current) => previous + current);
              return TotalBalanceBox(amount: sum);
            },
          ),
          const AddSpacing(),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
            child: SizedBox(
              width: width,
              height: 80,
              child: Row(
                children: [
                  ValueListenableBuilder<Box<TransactionModel>>(
                    valueListenable:
                        transactionViewModel.getTransactions().listenable(),
                    builder: (context, box, _) {
                      var data = box.values.toList().cast<TransactionModel>();
                      double sum = data
                          .where(
                              (transaction) => transaction.transactionType == 1)
                          .map((transaction) => transaction.amount)
                          .fold(0, (previous, current) => previous + current);
                      return ExpenseIncomeBox(
                        data: "Income",
                        amount: numToCurrency(sum, '0'),
                        icon: const Icon(
                          Icons.arrow_downward_sharp,
                          color: Colors.white,
                          size: 30,
                        ),
                        transactionType: 1,
                      );
                    },
                  ),
                  ValueListenableBuilder<Box<TransactionModel>>(
                    valueListenable:
                        transactionViewModel.getTransactions().listenable(),
                    builder: (context, box, _) {
                      var data = box.values.toList().cast<TransactionModel>();
                      double sum = data
                          .where(
                            (transaction) => transaction.transactionType == 0,
                          ) // Filter expenses
                          .map((transaction) =>
                              transaction.amount) // Convert amount to negative
                          .fold(
                            0,
                            (previous, current) => previous + current,
                          ); // Calculate sum
                      return ExpenseIncomeBox(
                        data: "Expense",
                        amount: numToCurrency(sum, '0'),
                        icon: const Icon(
                          Icons.arrow_upward_sharp,
                          color: Colors.white,
                          size: 30,
                        ),
                        transactionType: 0,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
            child: QuickActions(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: RecentTransactions(
              transactionViewModel: transactionViewModel,
            ),
          )
        ],
      ),
    );
  }
}
