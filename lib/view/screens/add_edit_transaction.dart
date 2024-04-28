import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/model/accounts_model.dart';
import 'package:expense_tracker_2024/model/category_model.dart';
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
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: APP_BG_WHITE),
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: MAIN_APP_COLOR,
              ),
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: appBar(
                context,
                transactionViewModel,
              ),
            ),
            Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: amountTextField(),
              ),
            ),
            Positioned(
              top: 200,
              left: 20,
              right: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  label("Transaction Type"),
                  const AddSpacing(),
                  incomeExpenseBoxes(transactionViewModel),
                  const AddSpacing(),
                  label("Choose Account"),
                  const AddSpacing(),
                  accountList(transactionViewModel),
                  const AddSpacing(),
                  label("Select Category"),
                  const AddSpacing(),
                  categoryList(transactionViewModel),
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
            )
          ],
        ),
      ),
    );
  }

  Text label(String text) {
    return Text(
      text,
      style: GoogleFonts.lato(
        fontSize: 13,
        color: TEXT_GREY_DARK,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Container appBar(
      BuildContext context, TransactionViewModel transactionViewModel) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding:
          const EdgeInsets.only(top: 50.0, left: 10, right: 0, bottom: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => {
                  AppNavigator.onNavigatorPop(context),
                  transactionViewModel.resetData(),
                  amountTextController.clear()
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
        ],
      ),
    );
  }

  Row incomeExpenseBoxes(TransactionViewModel transactionViewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TransactionType(
          icon: Icons.arrow_downward_sharp,
          isSelected: transactionViewModel.selectedTransactionType == 1,
          type: "Income",
          selectedType: () {
            transactionViewModel.setSelectedTransactionType(1);
          },
        ),
        TransactionType(
          icon: Icons.arrow_upward_sharp,
          isSelected: transactionViewModel.selectedTransactionType == 0,
          type: "Expense",
          selectedType: () {
            transactionViewModel.setSelectedTransactionType(0);
          },
        ),
      ],
    );
  }

  TextField amountTextField() {
    return TextField(
      textAlign: TextAlign.center,
      controller: amountTextController,
      keyboardType:
          const TextInputType.numberWithOptions(decimal: true, signed: true),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        hintText: "0.00",
        hintStyle: TextStyle(color: MAIN_APP_COLOR_LIGHT_HINT),
      ),
      style: GoogleFonts.lato(
        fontSize: 25,
        color: MAIN_APP_COLOR,
      ),
    );
  }

  SizedBox accountList(TransactionViewModel transactionViewModel) {
    return SizedBox(
      height: 100,
      child: ValueListenableBuilder<Box<AccountsModel>>(
        valueListenable: transactionViewModel.getAccounts().listenable(),
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
                      selectedIndex: transactionViewModel.selectedAccountIndex,
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
    );
  }

  SizedBox categoryList(TransactionViewModel transactionViewModel) {
    return SizedBox(
      height: 100,
      child: ValueListenableBuilder<Box<CategoryModel>>(
        valueListenable: transactionViewModel.getCategories().listenable(),
        builder: (context, box, _) {
          var data = box.values
              .where((element) =>
                  element.categoryType ==
                  transactionViewModel.selectedTransactionType)
              .toList()
              .cast<CategoryModel>();

          return data.isNotEmpty
              ? ListView.builder(
                  itemExtent: 80.0,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return AccountSelection(
                      index: index,
                      selectedIndex: transactionViewModel.selectedCategoryIndex,
                      icon: Icons.category,
                      accountName: data[index].categoryName,
                      getSelectedIndex: (selectedIndex) {
                        transactionViewModel.setCategoryIndex(
                          selectedIndex,
                          data[index].categoryId,
                          data[index].categoryName,
                        );
                      },
                    );
                  },
                )
              : const NoDataAvailable(message: "No Categories Yet");
        },
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
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          transactionViewModel.createTransaction(amountTextController.text);
          final errorMessage = transactionViewModel.errorMessage;
          final successMessage = transactionViewModel.message;
          if (errorMessage != "") {
            showErrorSnackbar(context, errorMessage);
          }
          if (successMessage != "") {
            showSuccessSnackbar(context, successMessage);
            amountTextController.clear();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Create Transaction".toUpperCase(),
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
