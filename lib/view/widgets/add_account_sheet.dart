import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/view/widgets/snackbar_messages.dart';
import 'package:expense_tracker_2024/view/widgets/spacing.dart';
import 'package:expense_tracker_2024/viewModel/accounts_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAccountSheet extends StatefulWidget {
  final AccountsViewModel accountsViewModel;

  const AddAccountSheet({super.key, required this.accountsViewModel});

  @override
  State<AddAccountSheet> createState() => _AddAccountSheetState();
}

class _AddAccountSheetState extends State<AddAccountSheet> {
  final TextEditingController openingBalanceTextController =
      TextEditingController();
  final TextEditingController accountNameTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final accountsViewModel = widget.accountsViewModel;
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.all(20.0),
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                Text(
                  "New Account",
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: MAIN_APP_COLOR),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            const AddSpacing(),
            const AddSpacing(),
            Focus(
              child: TextField(
                controller: accountNameTextController,
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  fillColor: Colors.red.shade50,
                  filled: true,
                  label: Text("Account Name",
                      style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            const AddSpacing(),
            Focus(
              child: TextField(
                controller: openingBalanceTextController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  fillColor: Colors.red.shade50,
                  filled: true,
                  label: Text(
                    "Opening Balance",
                    style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const AddSpacing(),
            Container(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MAIN_APP_COLOR_DARK,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  accountsViewModel.createAccount(
                    accountNameTextController.text,
                    openingBalanceTextController.text,
                  );
                  final errorMessage = accountsViewModel.errorMessage;
                  final successMessage = accountsViewModel.message;
                  if (errorMessage != "") {
                    Navigator.of(context).pop();
                    showErrorSnackbar(context, errorMessage);
                  }
                  if (successMessage != "") {
                    Navigator.of(context).pop();
                    showSuccessSnackbar(context, successMessage);
                  }
                },
                child: Text(
                  "Add Account".toUpperCase(),
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
