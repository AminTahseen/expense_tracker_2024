import 'package:expense_tracker_2024/model/accounts_model.dart';
import 'package:expense_tracker_2024/repositoryImpl/local/accounts_repo_impl.dart';
import 'package:expense_tracker_2024/repositoryImpl/local/transaction_repo_impl.dart';
import 'package:expense_tracker_2024/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class TransactionViewModel extends ChangeNotifier {
  final transactionRepo = TransactionRepoImpl();
  final accountsRepo = AccountsRepoImpl();
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

  setCategoryIndex(int index) {
    _selectedCategoryIndex = index;
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
      if (_validate(amount, selectedTransactionType, selectedAccountId, "1")) {
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
          categoryId: "1",
          createdByUserId: "1",
          transactionId: transactionId,
          accountName: selectedAccountName,
          categoryName: "default",
          createdOn: formattedDate,
        );
        print(transactionModel.toString());
        transactionRepo.insert(transactionModel);
        setMessage("Transaction Created Successfully");
        clearMessage();
        setLoader(false);
      }
    } catch (e) {
      setErrorMessage(e.toString());
    }
  }

  Box<AccountsModel> getAccounts() {
    return accountsRepo.getData();
  }

  Box<TransactionModel> getTransactions() {
    return transactionRepo.getData();
  }

  clearMessage() {
    Future.delayed(const Duration(seconds: 2), () {
      setErrorMessage("");
      setMessage("");
    });
  }

  bool _validate(
    String amount,
    int transactionType,
    String accountId,
    String categoryId,
  ) {
    if (amount.isEmpty || amount == "0.0") {
      setErrorMessage("Amount must be provided");
      return false;
    } else if (accountId == "") {
      setErrorMessage("Select an account please");
      return false;
    } else if (categoryId == "") {
      return false;
    }

    return true;
  }
}
