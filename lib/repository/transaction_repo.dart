import 'package:expense_tracker_2024/model/transaction_model.dart';
import 'package:hive_flutter/adapters.dart';

abstract class TransactionRepo {
  insert(TransactionModel model);
  Box<TransactionModel> getData();
}
