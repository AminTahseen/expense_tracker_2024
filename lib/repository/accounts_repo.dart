import 'package:expense_tracker_2024/model/accounts_model.dart';
import 'package:hive_flutter/adapters.dart';

abstract class AccountsRepo {
  insert(AccountsModel model);
  Box<AccountsModel> getData();
  update(AccountsModel model);
  AccountsModel getSingleData(String accountId);
}
