import 'package:expense_tracker_2024/model/category_model.dart';
import 'package:expense_tracker_2024/repositoryImpl/local/category_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ChartsViewModel extends ChangeNotifier {
  final categoryRepo = CategoryRepoImpl();

  Box<CategoryModel> getCategories() {
    return categoryRepo.getData();
  }
}
