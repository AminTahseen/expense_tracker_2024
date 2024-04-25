import 'package:hive/hive.dart';
part 'category_model.g.dart';

@HiveType(typeId: 2)
class CategoryModel extends HiveObject {
  @HiveField(0)
  String categoryId;

  @HiveField(1)
  String categoryName;

  @HiveField(2)
  double createdByUserId;

  @HiveField(3)
  int categoryType;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.createdByUserId,
    required this.categoryType,
  });
}
