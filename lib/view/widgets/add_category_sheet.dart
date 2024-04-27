import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/helpers/helpers.dart';
import 'package:expense_tracker_2024/view/widgets/snackbar_messages.dart';
import 'package:expense_tracker_2024/view/widgets/spacing.dart';
import 'package:expense_tracker_2024/view/widgets/transaction_type.dart';
import 'package:expense_tracker_2024/viewModel/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddCategorySheet extends StatefulWidget {
  const AddCategorySheet({super.key});

  @override
  State<AddCategorySheet> createState() => _AddCategorySheetState();
}

class _AddCategorySheetState extends State<AddCategorySheet> {
  final TextEditingController categoryNameTextController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    CategoryViewModel categoryViewModel = context.watch<CategoryViewModel>();

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
                  "New Category",
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
            Focus(
              child: TextField(
                controller: categoryNameTextController,
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  fillColor: Colors.red.shade50,
                  filled: true,
                  label: Text(
                    "Category Name",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const AddSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TransactionType(
                  icon: Icons.arrow_downward_sharp,
                  isSelected: categoryViewModel.selectedTransactionType == 1,
                  type: "Income",
                  selectedType: () =>
                      categoryViewModel.setSelectedTransactionType(1),
                ),
                const AddSpacing(),
                TransactionType(
                  icon: Icons.arrow_upward_sharp,
                  isSelected: categoryViewModel.selectedTransactionType == 0,
                  type: "Expense",
                  selectedType: () =>
                      categoryViewModel.setSelectedTransactionType(0),
                ),
              ],
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
                  categoryViewModel.createCategory(
                    categoryNameTextController.text.capitalize(),
                  );
                  final errorMessage = categoryViewModel.errorMessage;
                  final successMessage = categoryViewModel.message;
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
                  "Add Category".toUpperCase(),
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
