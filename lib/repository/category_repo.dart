import 'package:expense_tracker_2024/model/category_model.dart';
import 'package:hive_flutter/adapters.dart';

abstract class CategoryRepo {
  insert(CategoryModel model);

  Box<CategoryModel> getData();
}
