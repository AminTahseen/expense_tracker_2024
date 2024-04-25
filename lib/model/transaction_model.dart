import 'package:hive/hive.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel extends HiveObject {
  @HiveField(0)
  double amount;

  @HiveField(1)
  int transactionType;

  @HiveField(2)
  String accountId;

  @HiveField(3)
  String categoryId;

  @HiveField(4)
  String createdByUserId;

  @HiveField(5)
  String transactionId;

  @HiveField(6)
  String accountName;

  @HiveField(7)
  String categoryName;

  @HiveField(8)
  String createdOn;

  TransactionModel({
    required this.amount,
    required this.transactionType,
    required this.accountId,
    required this.categoryId,
    required this.createdByUserId,
    required this.transactionId,
    required this.accountName,
    required this.categoryName,
    required this.createdOn,
  });

  @override
  String toString() {
    return "TransactionModel{amount: $amount, transactionType: $transactionType, accountId: $accountId, categoryId: $categoryId, createdByUserId: $createdByUserId, transactionId: $transactionId, accountName: $accountName, categoryName: $categoryName}";
  }
}
