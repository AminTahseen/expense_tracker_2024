import 'package:hive/hive.dart';
part 'accounts_model.g.dart';

@HiveType(typeId: 1)
class AccountsModel extends HiveObject {
  @HiveField(0)
  String accountId;

  @HiveField(1)
  String accountName;

  @HiveField(2)
  double createdByUserId;

  @HiveField(3)
  double openingBalance;

  AccountsModel({
    required this.accountId,
    required this.accountName,
    required this.createdByUserId,
    required this.openingBalance,
  });
}
