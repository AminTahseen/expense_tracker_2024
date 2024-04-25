import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/model/accounts_model.dart';
import 'package:expense_tracker_2024/navigator/navigator.dart';
import 'package:expense_tracker_2024/view/widgets/account_selection.dart';
import 'package:expense_tracker_2024/view/widgets/no_data_available.dart';
import 'package:expense_tracker_2024/view/widgets/snackbar_messages.dart';
import 'package:expense_tracker_2024/view/widgets/spacing.dart';
import 'package:expense_tracker_2024/view/widgets/transaction_type.dart';
import 'package:expense_tracker_2024/viewModel/transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class AddEditTransaction extends StatefulWidget {
  const AddEditTransaction({super.key});

  @override
  State<AddEditTransaction> createState() => _AddEditTransactionState();
}

class _AddEditTransactionState extends State<AddEditTransaction> {
  final TextEditingController amountTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TransactionViewModel transactionViewModel =
        context.watch<TransactionViewModel>();
    final loader = transactionViewModel.loader;

    return Scaffold(
      backgroundColor: APP_BG_WHITE,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: MAIN_APP_COLOR),
              padding: const EdgeInsets.only(
                  top: 50.0, left: 10, right: 0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => {
                      AppNavigator().onNavigatorPop(context),
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      "Manage Transactions",
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AddSpacing(),
                  Text(
                    "Enter Amount",
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      color: TEXT_GREY_DARK,
                    ),
                  ),
                  TextField(
                    controller: amountTextController,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: true),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      hintText: "250.00",
                      hintStyle: TextStyle(color: MAIN_APP_COLOR_LIGHT_HINT),
                      prefixIcon: Icon(
                        Icons.attach_money,
                        color: MAIN_APP_COLOR,
                      ),
                      suffix: Text(
                        "PKR",
                        style: GoogleFonts.lato(
                            color: MAIN_APP_COLOR, fontSize: 20),
                      ),
                    ),
                    style: GoogleFonts.lato(
                      fontSize: 30,
                      color: MAIN_APP_COLOR,
                    ),
                  ),
                  const AddSpacing(),
                  Text(
                    "Transaction Type",
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      color: TEXT_GREY_DARK,
                    ),
                  ),
                  const AddSpacing(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TransactionType(
                        icon: Icons.arrow_downward_sharp,
                        isSelected:
                            transactionViewModel.selectedTransactionType == 1,
                        type: "Income",
                        selectedType: () {
                          transactionViewModel.setSelectedTransactionType(1);
                        },
                      ),
                      TransactionType(
                        icon: Icons.arrow_upward_sharp,
                        isSelected:
                            transactionViewModel.selectedTransactionType == 0,
                        type: "Expense",
                        selectedType: () {
                          transactionViewModel.setSelectedTransactionType(0);
                        },
                      ),
                    ],
                  ),
                  const AddSpacing(),
                  Text(
                    "Choose Account",
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      color: TEXT_GREY_DARK,
                    ),
                  ),
                  const AddSpacing(),
                  SizedBox(
                    height: 100,
                    child: ValueListenableBuilder<Box<AccountsModel>>(
                      valueListenable:
                          transactionViewModel.getAccounts().listenable(),
                      builder: (context, box, _) {
                        var data = box.values.toList().cast<AccountsModel>();
                        return data.isNotEmpty
                            ? ListView.builder(
                                itemExtent: 80.0,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: box.length,
                                itemBuilder: (context, index) {
                                  return AccountSelection(
                                    index: index,
                                    selectedIndex: transactionViewModel
                                        .selectedAccountIndex,
                                    icon: Icons.person,
                                    accountName: data[index].accountName,
                                    getSelectedIndex: (selectedIndex) {
                                      transactionViewModel.setAccountIndex(
                                        selectedIndex,
                                        data[index].accountId,
                                        data[index].accountName,
                                      );
                                    },
                                  );
                                },
                              )
                            : const NoDataAvailable(message: "No Accounts Yet");
                      },
                    ),
                  ),
                  const AddSpacing(),
                  Text(
                    "Select Category",
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      color: TEXT_GREY_DARK,
                    ),
                  ),
                  const AddSpacing(),
                  const NoDataAvailable(message: "No Categories Yet"),
                  // SizedBox(
                  //   height: 100,
                  //   child: ListView(
                  //     itemExtent: 80.0,
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.horizontal,
                  //     children: [
                  //       AccountSelection(
                  //         index: 0,
                  //         selectedIndex: 0,
                  //         icon: Icons.category,
                  //         accountName: "Category 1",
                  //         getSelectedIndex: (p0) {},
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const AddSpacing(),
                  Center(
                    child: loader
                        ? const CircularProgressIndicator()
                        : CreateTransactionButton(
                            transactionViewModel: transactionViewModel,
                            amountTextController: amountTextController,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateTransactionButton extends StatelessWidget {
  final TextEditingController amountTextController;
  const CreateTransactionButton({
    super.key,
    required this.transactionViewModel,
    required this.amountTextController,
  });

  final TransactionViewModel transactionViewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: MAIN_APP_COLOR_DARK,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        onPressed: () {
          transactionViewModel.createTransaction(amountTextController.text);
          final errorMessage = transactionViewModel.errorMessage;
          final successMessage = transactionViewModel.message;
          if (errorMessage != "") {
            showErrorSnackbar(context, errorMessage);
          }
          if (successMessage != "") {
            showSuccessSnackbar(context, successMessage);
          }
        },
        child: Text(
          "Create Transaction".toUpperCase(),
          style: GoogleFonts.lato(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
