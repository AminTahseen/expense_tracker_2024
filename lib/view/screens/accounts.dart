import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/model/accounts_model.dart';
import 'package:expense_tracker_2024/navigator/navigator.dart';
import 'package:expense_tracker_2024/view/widgets/account_item.dart';
import 'package:expense_tracker_2024/view/widgets/add_account_sheet.dart';
import 'package:expense_tracker_2024/view/widgets/no_data_available.dart';
import 'package:expense_tracker_2024/viewModel/accounts_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  @override
  Widget build(BuildContext context) {
    AccountsViewModel accountsViewModel = context.watch<AccountsViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: APP_BG_WHITE,
      body: Column(
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
                GestureDetector(
                  onTap: () {
                    AppNavigator().onNavigatorPop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "All Accounts",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FloatingActionButton.small(
                  heroTag: "AccountsButton",
                  elevation: 2,
                  shape: const CircleBorder(),
                  onPressed: () =>
                      _settingModalBottomSheet(context, accountsViewModel),
                  backgroundColor: MAIN_APP_COLOR_DARK,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<Box<AccountsModel>>(
              valueListenable: accountsViewModel.getAccounts().listenable(),
              builder: (context, box, _) {
                var data2 = box.values.toList().cast<AccountsModel>();
                var data = data2.reversed.toList().cast<AccountsModel>();
                return data.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          return AccountItem(
                            accountId: data[index].accountId,
                            category: data[index].accountName,
                            amount: data[index].openingBalance,
                            icon: Icons.person,
                          );
                        },
                      )
                    : const NoDataAvailable(message: "No Accounts Available");
              },
            ),
          ),
        ],
      ),
    );
  }
}

void _settingModalBottomSheet(context, AccountsViewModel viewModel) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext bc) {
      return AddAccountSheet(
        accountsViewModel: viewModel,
      );
    },
  );
}
