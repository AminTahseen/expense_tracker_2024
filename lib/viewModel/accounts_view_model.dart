import 'package:expense_tracker_2024/model/accounts_model.dart';
import 'package:expense_tracker_2024/repositoryImpl/local/accounts_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

class AccountsViewModel extends ChangeNotifier {
  final accountsRepo = AccountsRepoImpl();

  String _message = "";
  String get message => _message;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  setMessage(String message) async {
    _message = message;
    notifyListeners();
  }

  setErrorMessage(String message) async {
    _errorMessage = message;
    notifyListeners();
  }

  createAccount(String accountName, String openingBalance) async {
    if (_validate(accountName, openingBalance)) {
      final parsedAmount = double.parse(openingBalance);
      var uuid = const Uuid();
      var accountId = uuid.v1(); // -> '6c84fb90-12c4-11e1-840d-7b25c5ee775a'
      setErrorMessage("");
      final accountModel = AccountsModel(
        accountId: accountId,
        accountName: accountName,
        createdByUserId: 1,
        openingBalance: parsedAmount,
      );
      accountsRepo.insert(accountModel);
      setMessage("Account Created Successfully");
      clearMessage();
    }
  }

  Box<AccountsModel> getAccounts() {
    return accountsRepo.getData();
  }

  clearMessage() {
    Future.delayed(const Duration(seconds: 2), () {
      setErrorMessage("");
      setMessage("");
    });
  }

  bool _validate(String accountName, String openingBalance) {
    if (accountName.isEmpty) {
      setErrorMessage("An account name is required");
      return false;
    } else if (openingBalance.isEmpty || openingBalance == "0.0") {
      setErrorMessage("Opening balance is required");
      return false;
    }
    return true;
  }
}
