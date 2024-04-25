import 'package:expense_tracker_2024/constants/constants.dart';
import 'package:expense_tracker_2024/model/transaction_model.dart';
import 'package:expense_tracker_2024/repository/transaction_repo.dart';
import 'package:hive/hive.dart';

class TransactionRepoImpl extends TransactionRepo {
  final _transactionBox = Hive.box<TransactionModel>(HIVE_TRANSACTION_BOX_NAME);

  @override
  insert(TransactionModel model) {
    _transactionBox.add(model);
    model.save();
  }

  @override
  Box<TransactionModel> getData() {
    return _transactionBox;
  }
}
