import 'package:expense_tracker_2024/constants/constants.dart';
import 'package:expense_tracker_2024/model/accounts_model.dart';
import 'package:expense_tracker_2024/repository/accounts_repo.dart';
import 'package:hive_flutter/adapters.dart';

class AccountsRepoImpl extends AccountsRepo {
  final _accountsBox = Hive.box<AccountsModel>(HIVE_ACCOUNTS_BOX_NAME);

  @override
  insert(AccountsModel model) {
    _accountsBox.add(model);
    model.save();
  }

  @override
  Box<AccountsModel> getData() {
    return _accountsBox;
  }
}
