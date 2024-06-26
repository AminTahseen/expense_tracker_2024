import 'package:expense_tracker_2024/model/accounts_model.dart';
import 'package:expense_tracker_2024/model/category_model.dart';
import 'package:expense_tracker_2024/repositoryImpl/local/accounts_repo_impl.dart';
import 'package:expense_tracker_2024/repositoryImpl/local/category_repo_impl.dart';
import 'package:expense_tracker_2024/repositoryImpl/local/transaction_repo_impl.dart';
import 'package:expense_tracker_2024/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class TransactionViewModel extends ChangeNotifier {
  final transactionRepo = TransactionRepoImpl();
  final accountsRepo = AccountsRepoImpl();
  final categoryRepo = CategoryRepoImpl();
  String _message = "";
  String get message => _message;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  bool _loader = false;
  bool get loader => _loader;

  bool showError = false;

  int _selectedAccountIndex = -1;
  int get selectedAccountIndex => _selectedAccountIndex;
  String selectedAccountId = "";
  String selectedAccountName = "";

  int _selectedCategoryIndex = -1;
  int get selectedCategoryIndex => _selectedCategoryIndex;
  String selectedCategoryId = "";
  String selectedCategoryName = "";

  int _selectedTransactionType = 1;
  int get selectedTransactionType => _selectedTransactionType;

  setSelectedTransactionType(int type) {
    _selectedTransactionType = type;
    notifyListeners();
  }

  setAccountIndex(int index, String accountId, String accountName) {
    _selectedAccountIndex = index;
    selectedAccountId = accountId;
    selectedAccountName = accountName;
    notifyListeners();
  }

  setCategoryIndex(int index, String categoryId, String categoryName) {
    _selectedCategoryIndex = index;
    selectedCategoryId = categoryId;
    selectedCategoryName = categoryName;
    notifyListeners();
  }

  setMessage(String message) async {
    _message = message;
    notifyListeners();
  }

  setErrorMessage(String message) async {
    _errorMessage = message;
    notifyListeners();
  }

  setLoader(bool loader) async {
    _loader = loader;
    notifyListeners();
  }

  // Creating a transaction object in hive
  createTransaction(
    String amount,
  ) async {
    try {
      if (_validate(
        amount,
        selectedTransactionType,
        selectedAccountId,
        selectedCategoryId,
      )) {
        final parsedAmount = double.parse(amount);
        var uuid = const Uuid();
        var transactionId =
            uuid.v1(); // -> '6c84fb90-12c4-11e1-840d-7b25c5ee775a'

        var now = DateTime.now();
        var formatter = DateFormat('yyyy-MM-dd');
        String formattedDate = formatter.format(now);

        setErrorMessage("");
        setLoader(true);
        final transactionModel = TransactionModel(
          amount: selectedTransactionType == 0 ? -parsedAmount : parsedAmount,
          transactionType: selectedTransactionType,
          accountId: selectedAccountId,
          categoryId: selectedCategoryId,
          createdByUserId: "1",
          transactionId: transactionId,
          accountName: selectedAccountName,
          categoryName: selectedCategoryName,
          createdOn: formattedDate,
        );
        final obj = accountsRepo.getSingleData(selectedAccountId);
        if (selectedTransactionType == 0) {
          final updatedBalance = obj.openingBalance - parsedAmount;
          if (updatedBalance > 0) {
            transactionRepo.insert(transactionModel);
            obj.openingBalance = updatedBalance;
            accountsRepo.update(obj);
            setMessage("Transaction Created Successfully");
            clearMessage();
          } else {
            setErrorMessage("Not Enough Balance in this account");
          }
        } else {
          final updatedBalance = obj.openingBalance + parsedAmount;
          transactionRepo.insert(transactionModel);
          obj.openingBalance = updatedBalance;
          accountsRepo.update(obj);
          setMessage("Transaction Created Successfully");
          clearMessage();
        }

        setLoader(false);
      }
    } catch (e) {
      setErrorMessage(e.toString());
    }
  }

  Box<AccountsModel> getAccounts() {
    return accountsRepo.getData();
  }

  Box<CategoryModel> getCategories() {
    return categoryRepo.getData();
  }

  Box<TransactionModel> getTransactions() {
    return transactionRepo.getData();
  }

  clearMessage() {
    resetData();
    Future.delayed(const Duration(seconds: 2), () {
      setErrorMessage("");
      setMessage("");
    });
  }

  resetData() {
    _selectedAccountIndex = -1;
    selectedAccountId = "";
    selectedAccountName = "";
    _selectedCategoryIndex = -1;
    selectedCategoryId = "";
    selectedCategoryName = "";
    _selectedTransactionType = 1;
    notifyListeners();
  }

  bool _validate(
    String amount,
    int transactionType,
    String accountId,
    String categoryId,
  ) {
    if (amount.isEmpty || amount == "0.0") {
      setErrorMessage("Enter valid amount please");
      return false;
    } else if (accountId == "") {
      setErrorMessage("Select an account please");
      return false;
    } else if (categoryId == "") {
      setErrorMessage("Select a category please");
      return false;
    } else {
      return true;
    }
  }
}
